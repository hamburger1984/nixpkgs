{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  libcap, libpcap, lm_sensors, libnl,
  kconfig, kcoreaddons, kdelibs4support, ki18n, kiconthemes, kitemviews,
  knewstuff, libksysguard, qtbase, systemsettings, networkmanager-qt
}:

mkDerivation {
  name = "ksysguard";
  meta.broken = lib.versionOlder qtbase.version "5.15.0";
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    kconfig kcoreaddons kitemviews knewstuff kiconthemes libksysguard
    kdelibs4support ki18n libcap libpcap lm_sensors libnl systemsettings
    networkmanager-qt
  ];
  propagatedBuildInputs = [ systemsettings ];
}
