# https://github.com/rossmacarthur/sheldon/releases/tag/0.7.4
{ rustPlatform, fetchFromGitHub, stdenvNoCC, pkg-config, openssl, libgit2, curl, darwin, ... }:
let
  name = "sheldon";
  version = "0.7.4";
in
rustPlatform.buildRustPackage {
  pname = name;
  inherit version;
  src = fetchFromGitHub {
    owner = "rossmacarthur";
    repo = name;
    rev = version;
    hash = "sha256-foIC60cD2U8/w40CVEgloa6lPKq/+dml70rBroY5p7Q=";
  };
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl libgit2 curl ] ++ builtins.filter (_: stdenvNoCC.isDarwin) [ darwin.Security ];
  cargoSha256 = "sha256-XY8FtZcTKoWB9GpooJv16OrqqRDKK86lor2TsyRxLtw=";
  doCheck = false;
}
