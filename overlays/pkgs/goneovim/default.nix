{stdenv, buildGoModule, fetchFromGitHub, neovim, qtbase} :

buildGoModule rec {
  pname = "goneovim";
  version = "0.4.7";

  src = fetchFromGitHub {
    owner = "akiyosi";
    repo = pname;
    rev = "dd0a6a0a992ccc2c547e97746801876b4201fa71";
    sha256 = "0209y8pj3kai3grsciynin8lw48xkkarj8ksza66dm3z0ym8bx2g";
  };

  buildInputs = [neovim.unwrapped qtbase];

  vendorSha256 = "1crphp41bfivfmfp3cl7pjca3ypds6mr3847msd4wvfq4g6imk5q";

  meta = with stdenv.lib;
  {
    description = " Neovim GUI written in Golang, using a Golang qt backend ";
    homepage = "https://github.com/akiyosi/goneovim";
    license = licenses.mit;
    maintainers = [maintainers.tfmoraes];
  };
}
