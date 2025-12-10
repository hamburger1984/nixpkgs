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
  version = "2.4.1";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    #owner = "zigpy";
    #repo = "zha-device-handlers";
    #tag = version;
    #hash = "sha256-F3NUZUepNKef9fJY/eBfbO90ZJXWyzyf5uaZmonaCmc=";

    owner = "hamburger1984";
    repo = "zha-device-handlers";
    rev = "5d6f00d5cd44b2cd0daf49d9c56885bf0a7ba561";
    hash = "sha256-iszVHvzBRQi5x4QiMPIm4rrDi3YjBLsOqW0OeezNaHw=";
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
