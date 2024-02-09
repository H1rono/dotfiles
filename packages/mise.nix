# https://github.com/jdx/mise/releases/tag/v2024.1.12
{ pkgs
, lib
, rustPlatform
, src
}:
let
  owner = "jdx";
  pname = "mise";
  version = "2024.1.12";
in
rustPlatform.buildRustPackage {
  inherit pname version src;

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
    homepage = "https://github.com/${owner}/${pname}";
    license = licenses.mit;
  };
}
