{
  description = "Emacs-CI flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    {
      overlay = (import ./overlay.nix);
    };
}
