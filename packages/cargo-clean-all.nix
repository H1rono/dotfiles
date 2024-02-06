# https://github.com/dnlmlr/cargo-clean-all/releases/tag/v0.6.2
{ pkgs
, lib
, stdenv
, fetchFromGitHub
, rustPlatform
, coreutils
, bash
, direnv
, openssl
, src
}:
let
  info = import ../nix/readInputInfo.nix "cargo-clean-all";
  inherit (info.original) owner ref repo;
in
rustPlatform.buildRustPackage {
  inherit src;
  pname = repo;
  version = ref;

  cargoLock.lockFile = "${src}/Cargo.lock";
  doCheck = false;

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  meta = with lib; {
    homepage = "https://github.com/dnlmlr/cargo-clean-all";
    license = licenses.mit;
  };
}
