# https://github.com/nix-community/fenix/blob/28dbd8b43ea328ee708f7da538c63e03d5ed93c8/default.nix#L5-L12
name:
let
  readInputInfo = import ./readInputInfo.nix;
  inputInfo = readInputInfo name;
  inherit (inputInfo.locked) owner repo rev narHash;
in
{
  inherit rev narHash;
  outPath = fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    sha256 = narHash;
  };
}
