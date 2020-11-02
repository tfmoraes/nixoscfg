#!/usr/bin/env bash

nix flake update --update-input nixpkgs
nix flake update --update-input home-manager
sudo nixos-rebuild switch --flake '.#'
