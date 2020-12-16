# Copied from https://github.com/terlar/nix-config

{ pkgs }:

with pkgs;


{
  update-flake = writeShellScriptBin "update-flake" ''
  nix flake update --update-input nixpkgs
  nix flake update --update-input home-manager
  nix flake update --update-input flake-utils
  '';

  home-switch = writeShellScriptBin "home-switch" ''
  echo "$FLAKE#homeConfigurations.$SYSTEM.$HM_USER.activationPackage"
  nix build --no-update-lock-file ".#homeManagerConfigurations.thiago.activationPackage"
  ./result/activate
  rm result
  '';

  update-system = writeShellScriptBin "update-system" ''
  sudo nixos-rebuild switch --flake '.#'
  '';
}
