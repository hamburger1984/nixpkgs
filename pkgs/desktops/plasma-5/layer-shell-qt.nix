{ mkDerivation
, lib
, extra-cmake-modules
, plasma-framework
, kdoctools
, qtbase
, qtdeclarative
, packagekit-qt
, wayland
, wayland-protocols
, plasma-wayland-protocols
, kwayland
}:

mkDerivation {
  name = "layer-shell-qt";
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    qtbase
    qtdeclarative
    plasma-framework
    packagekit-qt
    wayland
    wayland-protocols
    plasma-wayland-protocols
    kwayland
  ];
}
