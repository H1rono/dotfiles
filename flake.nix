{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix/monthly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, fenix, ... }:
    let
      user = "kh";
      rustToolchain = { system, fenix, ... }: fenix.fromToolchainFile {
        file = ./rust-toolchain.toml;
        sha256 = "sha256-SXRtAuO4IqNOQq+nLbrsDFbVk+3aVA8NNpSZsKlVH/8=";
      };
      rustPlatform = { callPackage, makeRustPlatform, ... }: makeRustPlatform rec {
        rustc = callPackage rustToolchain { };
        cargo = rustc;
      };
    in
    {
      overlays = {
        fenix = fenix.overlays.default;
        rustToolchain = final: prev: {
          rustToolchain = prev.callPackage rustToolchain { };
          rustPlatform = prev.callPackage rustPlatform { };
        };
        sheldon = final: prev: {
          sheldon = prev.callPackage ./packages/sheldon.nix { };
        };
        mise = final: prev: {
          mise = prev.callPackage ./packages/mise.nix { };
        };
        firge-nerd = final: prev: {
          firge-nerd = prev.callPackage ./packages/firge-nerd.nix { };
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.fenix
            self.overlays.rustToolchain
            self.overlays.sheldon
            self.overlays.mise
            self.overlays.firge-nerd
          ];
        };
      in
      {
        packages = {
          homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = {
              inherit fenix user;
            };
          };
          inherit (pkgs) rustToolchain sheldon mise firge-nerd;
        };
      });
}
