# https://github.com/rossmacarthur/sheldon/releases/tag/0.7.4
{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:
let
  name = "sheldon";
  version = "0.7.4";
  src = fetchFromGitHub {
    owner = "rossmacarthur";
    repo = name;
    rev = version;
    hash = "sha256-foIC60cD2U8/w40CVEgloa6lPKq/+dml70rBroY5p7Q=";
  };
in
rustPlatform.buildRustPackage {
  pname = name;
  inherit version src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  nativeBuildInputs = [ pkgs.pkg-config ];
  buildInputs = with pkgs; [
    openssl
    libgit2
    curl
  ] ++ lib.optionals stdenv.isDarwin [ darwin.Security ];
  doCheck = false;
}
