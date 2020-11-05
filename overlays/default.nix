{ config, ... }:

{
  nixpkgs.overlays = [
    (import ./neovim.nix)
    (import ./sumneko.nix)
    (import ./vimlsp.nix)
    (import ./toolbox.nix)
    (import ./python.nix)
  ];
}
