{ lib, buildPythonPackage, fetchFromGitHub }:

buildPythonPackage rec {
  pname ="pypubsub";
  version = "4.0.3";
  src = fetchFromGitHub {
    owner = "schollii";
    repo = "pypubsub";
    rev = "v4.0.3";
    sha256 = "02j74w28wzmdvxkk8i561ywjgizjifq3hgcl080yj0rvkd3wivlb";
  };
  doCheck = false;
}
