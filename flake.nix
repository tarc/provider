{
  description = "Flake module with a provider script";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-lib.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz?dir=lib";
    systems.url = "github:nix-systems/default";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, unstable, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { flake-parts-lib, ... }:
      let
        inherit (flake-parts-lib) importApply;
      in
      {
        flake.flakeModule = importApply ./envModule.nix {
          inherit flake-parts-lib;
          inherit (inputs) nixpkgs-lib;
          inherit unstable;
        };
      }
    );
}
