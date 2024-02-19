# https://github.com/rossmacarthur/sheldon/releases/tag/0.7.4
let
  fetchFlakeInput = import ../nix/fetchFlakeInput.nix;
  readInputInfo = import ../nix/readInputInfo.nix;
in
{ pkgs ? import (fetchFlakeInput "nixpkgs") { }
, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform
, fetchFromGitHub ? pkgs.fetchFromGitHub
, src ? fetchFlakeInput "sheldon"
}:
let
  info = readInputInfo "sheldon";
  inherit (info.original) ref repo;
in
rustPlatform.buildRustPackage {
  pname = repo;
  version = ref;
  inherit src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = with pkgs; [
    openssl
    libgit2
    curl
  ] ++ lib.optionals stdenv.isDarwin [ darwin.Security ];
  doCheck = false;
}
