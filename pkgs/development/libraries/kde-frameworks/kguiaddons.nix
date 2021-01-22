{ mkDerivation
, extra-cmake-modules
, qtbase, qtx11extras, libXdmcp, wayland,
}:

mkDerivation {
  name = "kguiaddons";

  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [ qtx11extras libXdmcp wayland ];
  propagatedBuildInputs = [ qtbase ];

  outputs = [ "out" "dev" ];
}
