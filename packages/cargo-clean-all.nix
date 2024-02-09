# https://github.com/dnlmlr/cargo-clean-all/releases/tag/v0.6.2
let
  fetchFlakeInput = import ../nix/fetchFlakeInput.nix;
  readInputInfo = import ../nix/readInputInfo.nix;
in
{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform
, src ? fetchFlakeInput "cargo-clean-all"
}:
let
  info = readInputInfo "cargo-clean-all";
  inherit (info.original) ref owner repo;
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
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
  };
}
