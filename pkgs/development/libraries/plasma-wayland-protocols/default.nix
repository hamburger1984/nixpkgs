{ mkDerivation, fetchurl, lib
, extra-cmake-modules
, qtbase
}:

mkDerivation rec {
  pname = "plasma-wayland-protocols";
  version = "1.2.1";

  src = fetchurl {
    url = "mirror://kde/stable/${pname}/${pname}-v${version}.tar.xz";
    sha256 = "287b90903f9a7f394c75e75cb187426862eaf64a92f1be7e2ef68e99fd8cbaaa";
  };

  nativeBuildInputs = [ extra-cmake-modules ];

  buildInputs = [ qtbase ];

  meta = {
    description = "Plasma Wayland Protocols";
    license = lib.licenses.lgpl21Plus;
    platforms = qtbase.meta.platforms;
    maintainers = [ lib.maintainers.ttuegel ];
  };
}
