{
  mkDerivation, lib, propagate, wrapGAppsHook,
  extra-cmake-modules, glib, gtk2, gtk3, gsettings-desktop-schemas,
  kdoctools,
  kconfig, kcoreaddons, kcrash, kdbusaddons, kinit, kservice, qtbase,
}:

mkDerivation {
  name = "kded";
  meta = { maintainers = [ lib.maintainers.ttuegel ]; };
  nativeBuildInputs = [ extra-cmake-modules wrapGAppsHook kdoctools ];
  dontWrapGApps = true;
  buildInputs = [
    kconfig kcoreaddons kcrash kdbusaddons kinit kservice qtbase
    gsettings-desktop-schemas glib gtk2 gtk3
  ];
  preFixup = ''
    qtWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  outputs = [ "out" "dev" ];
  setupHook = propagate "out";
}
