{
  lib,
  aiohttp,
  buildPythonPackage,
  fetchFromGitHub,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  time-machine,
  zigpy,
}:

buildPythonPackage rec {
  pname = "zha-quirks";
  version = "0.0.156";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    #owner = "zigpy";
    owner = "hamburger1984";
    #owner = "tomuk5";
    repo = "zha-device-handlers";
    #tag = version;
    #hash = "sha256-vVA8FmNLzatfClRTvb9pZm5SQxgSQh+iAllOl+OIo6Q=";
    hash = "sha256-m+cNwXbA9MsJGXCEyYCpzCgffNfpiA5ngInC2su3Qk0=";
    ##tag = version;
    rev = "483d775191a93778d7257f045b6fcdfbcd8976b5";
    #rev = "ad330c53ab2473828c563ab12aa518b60fa69e38";
    #hash = "sha256-9NS8kPSZ6tNU+M7s5eJ6j+okTwX04eZ3S8dpkXw9V7w=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail ', "setuptools-git-versioning<2"' "" \
      --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
  '';

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    zigpy
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
    time-machine
  ];

  disabledTests = [
    # AssertionError: expected call not found
    "test_moes"
    "test_tuya_mcu_set_time"
  ];

  disabledTestPaths = [
    # TypeError: unhashable type: 'dict'
    "tests/test_quirks_v2.py"
  ];

  pythonImportsCheck = [ "zhaquirks" ];

  meta = {
    description = "ZHA Device Handlers are custom quirks implementations for Zigpy";
    homepage = "https://github.com/dmulcahey/zha-device-handlers";
    changelog = "https://github.com/zigpy/zha-device-handlers/releases/tag/${src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ fab ];
    platforms = lib.platforms.linux;
  };
}
