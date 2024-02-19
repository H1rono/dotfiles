# https://github.com/jdx/mise/releases/tag/v2024.1.12
let
  fetchFlakeInput = import ../nix/fetchFlakeInput.nix;
  readInputInfo = import ../nix/readInputInfo.nix;
in
{ pkgs ? import (fetchFlakeInput "nixpkgs") { }
, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform
, src ? fetchFlakeInput "mise"
}:
let
  info = readInputInfo "mise";
  inherit (info.original) ref owner repo;
in
rustPlatform.buildRustPackage {
  inherit src;
  pname = repo;
  version = ref;

  cargoLock.lockFile = "${src}/Cargo.lock";
  doCheck = false;
  prePatch = ''
    substituteInPlace ./src/cli/direnv/exec.rs \
      --replace '"env"' '"${pkgs.coreutils}/bin/env"' \
      --replace 'cmd!("direnv"' 'cmd!("${pkgs.direnv}/bin/direnv"'
  '';

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    coreutils
    bash
    direnv
    gnused
    git
    gawk
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  meta = with lib; {
    description = "The front-end to your dev env";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
  };
}
