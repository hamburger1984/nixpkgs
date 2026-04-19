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
  version = "1.1.1";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    #owner = "zigpy";
    #repo = "zha-device-handlers";
    #tag = version;
    #hash = "sha256-lCcJCQ+/X3GpZPG3Li9f+sspFG+f2Ju3R6523jR1U2w=";

    owner = "hamburger1984";
    repo = "zha-device-handlers";
    rev = "7f3b2a3e523e04519e45250cd465eec90b426da0";
    hash = "";
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
    homepage = "https://github.com/zigpy/zha-device-handlers";
    changelog = "https://github.com/zigpy/zha-device-handlers/releases/tag/${src.tag}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ fab ];
    platforms = lib.platforms.linux;
  };
}
