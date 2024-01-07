# https://github.com/jdx/mise/releases/tag/v2024.1.12
{ pkgs, lib, stdenv, fetchFromGitHub, rustPlatform, coreutils, bash, direnv, openssl }:
let
  pname = "mise";
  version = "2024.1.12";
in
rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "jdx";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JzZMxu1/+TmbtEOkOCF7iEKi0CKh8/CZt8rgxZz8n50=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    coreutils
    bash
    direnv
    gnused
    git
    gawk
    openssl
  ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security darwin.apple_sdk.frameworks.SystemConfiguration ];
  cargoSha256 = "sha256-mGmFSd1kNvfo7bRlp+Ubi/wN2aAyIMzjlXtYAS9F5sw=";

  prePatch = ''
    substituteInPlace ./test/data/plugins/**/bin/* \
      --replace '#!/usr/bin/env bash' '#!${bash}/bin/bash'
    substituteInPlace ./src/fake_asdf.rs ./src/cli/reshim.rs \
      --replace '#!/bin/sh' '#!${bash}/bin/sh'
    substituteInPlace ./src/env_diff.rs \
      --replace '"bash"' '"${bash}/bin/bash"'
    substituteInPlace ./test/cwd/.mise/tasks/filetask \
      --replace '#!/usr/bin/env bash' '#!${bash}/bin/bash'
    substituteInPlace ./src/cli/direnv/exec.rs \
      --replace '"env"' '"${coreutils}/bin/env"' \
      --replace 'cmd!("direnv"' 'cmd!("${direnv}/bin/direnv"'
  '';
  doCheck = false;

  meta = with lib; {
    description = "The front-end to your dev env";
    homepage = "https://github.com/jdx/mise";
    license = licenses.mit;
  };
}
