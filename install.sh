#!/bin/bash

cd "$(dirname "$0")"

SRC_DIR="$(pwd)"
DEST_DIR="${1:-$HOME}"

echo "install dotfiles from \`$SRC_DIR\` into \`$DEST_DIR\` ..."

function setlink() {
    local SRC="$1"
    local DEST="$2"
    if [ -f "$DEST" ]; then
        echo "found \`$DEST\`, move it into \`$DEST.old\`"
        mv "$DEST" "$DEST.old"
    fi
    echo "create a symbolic link to \`$SRC\` at \`$DEST\`"
    ln -s "$SRC" "$DEST"
}

setlink "$SRC_DIR/zshrc" "$DEST_DIR/.zshrc"
setlink "$SRC_DIR/wezterm.lua" "$DEST_DIR/.wezterm.lua"
setlink "$SRC_DIR/tmux.conf" "$DEST_DIR/.tmux.conf"

echo "mkdir -p \"$DEST_DIR/.config\""
mkdir -p "$DEST_DIR/.config"
setlink "$SRC_DIR/config/starship.toml" "$DEST_DIR/.config/starship.toml"

echo "mkdir -p \"$DEST_DIR/.config/nvim\""
mkdir -p "$DEST_DIR/.config/nvim"
setlink "$SRC_DIR/config/nvim/init.vim" "$DEST_DIR/.config/nvim/init.vim"

echo "mkdir -p \"$DEST_DIR/.config/sheldon\""
mkdir -p "$DEST_DIR/.config/sheldon"
setlink "$SRC_DIR/config/sheldon/plugins.toml" "$DEST_DIR/.config/sheldon/plugins.toml"

echo "done."

