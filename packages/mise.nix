# https://github.com/jdx/mise/releases/tag/v2024.1.12
{ pkgs
, lib
, fetchFromGitHub
, rustPlatform
}:
let
  owner = "jdx";
  pname = "mise";
  version = "2024.1.12";
  src = fetchFromGitHub {
    inherit owner;
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JzZMxu1/+TmbtEOkOCF7iEKi0CKh8/CZt8rgxZz8n50=";
  };
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
