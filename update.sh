#!/usr/bin/env bash

set -euxo pipefail

nix flake update --update-input nixpkgs
nix flake update --update-input home-manager
sudo nixos-rebuild switch --flake '.#'
