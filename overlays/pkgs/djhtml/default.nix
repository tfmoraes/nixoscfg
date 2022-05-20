{
  lib,
  pkgs,
  buildPythonPackage,
  fetchPypi,
  unzip,
  python,
}:
buildPythonPackage rec {
  pname = "djhtml";
  version = "1.5.0";
  src = fetchPypi {
    inherit pname version;
    sha256 = "eeccc5e5cc6d1371e8434903de5043b24efa1000b6857b9bf342e1868aa995ae";
  };
}
