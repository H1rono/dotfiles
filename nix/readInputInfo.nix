let
  readFlakeLock = import ./readFlakeLock.nix;
in
name:
(readFlakeLock).nodes.${name}
