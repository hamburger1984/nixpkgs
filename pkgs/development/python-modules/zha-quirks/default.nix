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
  zha,
  zigpy,
}:

buildPythonPackage rec {
  pname = "zha-quirks";
  version = "2.3.0";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    #owner = "zigpy";
    #repo = "zha-device-handlers";
    #tag = version;
    #hash = "sha256-F3NUZUepNKef9fJY/eBfbO90ZJXWyzyf5uaZmonaCmc=";

    owner = "hamburger1984";
    repo = "zha-device-handlers";
    rev = "5a73c6c94c0c31e252e7f5ac7bad33e0e73c5b7a";
    hash = "sha256-5A6rNhEnEt9xTUCHoY2wn1Lzj9TrftXK94cfwhdR0S0=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail ', "setuptools-git-versioning<2"' "" \
      --replace-fail 'dynamic = ["version"]' 'version = "${version}"'
  '';

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    zha
    zigpy
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
    time-machine
  ];

  disabledTests = [
    # AssertionError: expected call not found
    "test_tuya_mcu_set_time"
    "test_moes"
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
