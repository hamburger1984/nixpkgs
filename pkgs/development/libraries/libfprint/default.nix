{ stdenv
, fetchFromGitLab
, pkgconfig
, gdb
, valgrind
, meson
, ninja
, gusb
, pixman
, glib
, nss
, gobject-introspection
, coreutils
, gtk-doc
, docbook_xsl
, docbook_xml_dtd_43
, cairo
}:

stdenv.mkDerivation rec {
  pname = "libfprint";
  version = "1.90.5";
  outputs = [ "out" "devdoc" ];

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "libfprint";
    repo = pname;
    rev = "v${version}";
    sha256 = "1wfwka2ik4hbb5wk5dp533040sqygwswg91c3v5fvpmmixh5qx9j";
  };

  nativeBuildInputs = [
    pkgconfig
    gdb
    valgrind
    meson
    ninja
    gtk-doc
    docbook_xsl
    docbook_xml_dtd_43
    gobject-introspection
    cairo
  ];

  buildInputs = [
    gusb
    pixman
    glib
    nss
  ];

  NIX_CFLAGS_COMPILE = "-Wno-error=array-bounds";

  mesonFlags = [
    "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
  ];

  meta = with stdenv.lib; {
    homepage = "https://fprint.freedesktop.org/";
    description = "A library designed to make it easy to add support for consumer fingerprint readers";
    license = licenses.lgpl21;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abbradar ];
  };
}
