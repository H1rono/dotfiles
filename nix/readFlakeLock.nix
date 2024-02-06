let inherit (builtins) fromJSON readFile;
in
fromJSON (readFile ../flake.lock)
