# https://github.com/dnlmlr/cargo-clean-all/releases/tag/v0.6.2
{ pkgs, lib, stdenv, fetchFromGitHub, rustPlatform, coreutils, bash, direnv, openssl }:
let
  pname = "cargo-clean-all";
  version = "v0.6.2";
  src = fetchFromGitHub {
    owner = "dnlmlr";
    repo = pname;
    rev = version;
    hash = "sha256-rNwAzpBUAFDt6SpVi1htAMTB7TUD4YqpxJkd3hYCPAQ=";
  };
in
rustPlatform.buildRustPackage {
  inherit pname version src;

  cargoLock.lockFile = "${src}/Cargo.lock";
  doCheck = false;

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  meta = with lib; {
    homepage = "https://github.com/dnlmlr/cargo-clean-all";
    license = licenses.mit;
  };
}
