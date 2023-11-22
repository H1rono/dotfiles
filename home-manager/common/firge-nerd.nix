{ lib, stdenvNoCC, fetchzip }:
let
  repository-url = "https://github.com/yuru7/Firge";
in
stdenvNoCC.mkDerivation rec {
  pname = "firge-nerd-font";
  version = "0.2.0";

  src = fetchzip {
    url = "${repository-url}/releases/download/v${version}/FirgeNerd_v${version}.zip";
    hash = "sha256-KZHTWGJCE8bPdcKGRYV92hGArgY7uvZ+v75vz0I7Oqg=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/firge-nerd

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fira Mono と源真ゴシックを合成したプログラミングフォント Firge (ファージ)";
    homepage = "${repository-url}";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
