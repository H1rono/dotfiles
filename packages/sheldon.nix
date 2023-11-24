# https://github.com/rossmacarthur/sheldon/releases/tag/0.7.4
{ makeRustPlatform, fetchFromGitHub, stdenvNoCC, pkg-config, openssl, libgit2, curl, darwin, fenix, ... }:
let
  toolchain = fenix.packages."aarch64-darwin".minimal.toolchain;
  version = "0.7.4";
in
(makeRustPlatform {
  rustc = toolchain;
  cargo = toolchain;
}).buildRustPackage {
  pname = "sheldon";
  inherit version;
  src = fetchFromGitHub {
    owner = "rossmacarthur";
    repo = "sheldon";
    rev = version;
    hash = "sha256-foIC60cD2U8/w40CVEgloa6lPKq/+dml70rBroY5p7Q=";
  };
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl libgit2 curl ] ++ builtins.filter (_: stdenvNoCC.isDarwin) [ darwin.Security ];
  cargoSha256 = "sha256-XY8FtZcTKoWB9GpooJv16OrqqRDKK86lor2TsyRxLtw=";
  doCheck = false;
}
