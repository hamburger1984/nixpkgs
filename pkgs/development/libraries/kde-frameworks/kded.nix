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
  cmakeFlags = [
    "-DGTK2_GLIBCONFIG_INCLUDE_DIR=${glib.out}/lib/glib-2.0/include"
    "-DGTK2_GDKCONFIG_INCLUDE_DIR=${gtk2.out}/lib/gtk-2.0/include"
    "-DGLIB_SCHEMAS_DIR=${gsettings-desktop-schemas.out}/"
  ];
  preConfigure = ''
    NIX_CFLAGS_COMPILE+=" -DGSETTINGS_SCHEMAS_PATH=\"$GSETTINGS_SCHEMAS_PATH\""
  '';

  outputs = [ "out" "dev" ];
  setupHook = propagate "out";
}
