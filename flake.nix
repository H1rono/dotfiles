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
    # non-flake inputs
    cargo-clean-all = {
      url = "github:dnlmlr/cargo-clean-all/v0.6.2";
      flake = false;
    };
    mise = {
      url = "github:jdx/mise/v2024.1.12";
      flake = false;
    };
    sheldon = {
      url = "github:rossmacarthur/sheldon/0.7.4";
      flake = false;
    };
  };

  outputs =
    inputs@{ self
      # flakes
    , nixpkgs
    , flake-utils
    , home-manager
    , fenix
      # non-flakes
    , cargo-clean-all
    , mise
    , sheldon
    , ...
    }:
    let
      user = "kh";
      rustToolchain = { system, fenix, ... }: fenix.fromToolchainFile {
        file = ./rust-toolchain.toml;
        sha256 = "sha256-e4mlaJehWBymYxJGgnbuCObVlqMlQSilZ8FljG9zPHY=";
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
        };
        rustPlatform = final: prev: {
          rustPlatform = prev.callPackage rustPlatform { };
        };
        mise = final: prev: {
          mise = prev.callPackage ./packages/mise.nix {
            src = mise;
          };
        };
        firge-nerd = final: prev: {
          firge-nerd = prev.callPackage ./packages/firge-nerd.nix { };
        };
        cargo-clean-all = final: prev: {
          cargo-clean-all = prev.callPackage ./packages/cargo-clean-all.nix {
            src = cargo-clean-all;
          };
        };
        sheldon = final: prev: {
          sheldon = prev.callPackage ./packages/sheldon.nix {
            src = sheldon;
          };
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.fenix
          self.overlays.rustToolchain
          self.overlays.mise
          self.overlays.firge-nerd
          self.overlays.cargo-clean-all
          self.overlays.sheldon
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
            inherit user;
          };
        };
        inherit (pkgs) rustToolchain sheldon mise firge-nerd cargo-clean-all;
      };
    });
}
