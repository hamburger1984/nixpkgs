{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  libcap, libnl, libpcap, lm_sensors,
  kconfig, kcoreaddons, kdelibs4support, ki18n, kiconthemes, kitemviews,
  knewstuff, libksysguard, qtbase,
  networkmanager-qt,
}:

mkDerivation {
  name = "ksysguard";
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    kconfig kcoreaddons kitemviews kinit kiconthemes knewstuff libksysguard
    ki18n libcap libpcap lm_sensors networkmanager-qt libnl
  ];
}
