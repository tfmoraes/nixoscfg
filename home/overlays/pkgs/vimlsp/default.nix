{
  lib, fetchFromGitHub, mkYarnPackage, makeWrapper
}:
mkYarnPackage {
  pname = "vimlsp";
  version = "2.0.0";
  src = fetchFromGitHub{
    owner = "iamcco";
    repo = "vim-language-server";
    rev = "v2.0.0";
    sha256 = "0blpi4cqpdpla260z5fackii4fsngcyh42nkg6xwh571a6c7ic3r";
  };
  buildPhase = "PUBLIC_URL=. yarn build";
}
