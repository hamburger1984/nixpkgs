{ stdenv
, buildPythonPackage
, fetchPypi
, isPy27
, lib
}: buildPythonPackage rec {
  pname = "sgmllib3k";
  version = "1.0.0";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1s8jm3dgqabgf8x96931scji679qkhvczlv3qld4qxpsicfgns3q";
  };

  # N.B. Tests are completely broken. The package doesn't even ship with the
  # necessary files for tests to run.
  doCheck = false;

  pythonImportsCheck = "sgmllib";

  meta = with lib; {
    homepage = "https://pypi.org/project/sgmllib3k/";
    description = "Python 3 port of sgmllib";
    license = licenses.bsd2;
    maintainers = with maintainers; [ lovesegfault ];
  };
}
