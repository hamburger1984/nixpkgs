{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, pytz
, simplejson
, packaging
}:

buildPythonPackage rec {
  pname = "marshmallow";
  version = "3.15.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "marshmallow-code";
    repo = pname;
    rev = version;
    hash = "sha256-ZqMrMNfP/RKW2jQDNPgfhyeqmSc40pZbnrcXHbw2emc=";
  };

  propagatedBuildInputs = [
    packaging
  ];

  checkInputs = [
    pytestCheckHook
    pytz
    simplejson
  ];

  pythonImportsCheck = [
    "marshmallow"
  ];

  meta = with lib; {
    description = "Library for converting complex objects to and from simple Python datatypes";
    homepage = "https://github.com/marshmallow-code/marshmallow";
    license = licenses.mit;
    maintainers = with maintainers; [ cript0nauta ];
  };
}
