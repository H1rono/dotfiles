#!/bin/bash

if [ -f .env ] ; then
    # ref: https://qiita.com/reflet/items/2caf9dbf0e3f775276ec
    export $(cat .env | grep -v '^#' | xargs)
else
    touch .env
fi

DEST_DIR="${1:-${LAST_DEST_DIR:-$HOME}}"
mkdir -p "$DEST_DIR"
DEST_DIR=`readlink -f "$DEST_DIR"`

cd `dirname "$0"`

SRC_DIR="$(pwd)"

DOTFILES_STATUS="${DOTFILES_STATUS:-not_installed}"
[ "$DEST_DIR" != "$LAST_DEST_DIR" ] && export DOTFILES_STATUS="not_installed"

# this should be synced with `home-manager/${each-platform}/home.nix`
# for each line: $SRC_DIR/$line[0] -> $DEST_DIR/$line[1]
INSTALL_MAPPINGS="
zshrc                       .zshrc
wezterm.lua                 .wezterm.lua
tmux.conf                   .tmux.conf
config/starship.toml        .config/starship.toml
config/bat/config.conf      .config/bat/config
config/nvim/init.vim        .config/nvim/init.vim
config/rtx/config.toml      .config/rtx/config.toml
config/sheldon/plugins.toml .config/sheldon/plugins.toml
config/git/gitmessage.txt   .config/git/gitmessage.txt
"

case "$DOTFILES_STATUS" in
    "not_installed" )
        echo "this dotfiles repository is not installed, install dotfiles from \`$SRC_DIR\` into \`$DEST_DIR\`"
    ;;
    "installed" )
        echo "this dotfiles repository is already installed, update symlinks from \`$SRC_DIR\` into \`$DEST_DIR\`"
    ;;
    * )
        echo "ERROR! unexpected environment variable DOTFILES_STATUS='$DOTFILES_STATUS', please check the content of .env"
        exit 1
    ;;
esac

function check_installed() {
    if   [ -L "$1" ] ; then
        echo "\`$1\` is a simbolic link, unlink this"
        unlink "$1"
    elif [ -f "$1" ] ; then
        echo "\`$1\` is a file, move to \`$1.old\` (if \`$1.old\` exists, remove it)"
        [ -e "$1.old" ] && rm "$1.old"
        mv "$1" "$1.old"
    fi
}

echo "$INSTALL_MAPPINGS" | while read MAP
do
    [ ! -n "$MAP" ] && continue
    ARGS=($MAP)
    SRC="$SRC_DIR/${ARGS[0]}"
    DEST="$DEST_DIR/${ARGS[1]}"
    DEST_D=`dirname "$DEST"`
    echo "mkdir -p '$DEST_D'"
    mkdir -p "$DEST_D"
    check_installed "$DEST"
    echo "create a symbolic link to \`$SRC\` at \`$DEST\`"
    ln -s "$SRC" "$DEST"
done

echo "update git commit template"
git config --global commit.template "$DEST_DIR/.config/git/gitmessage.txt"

echo "update $SRC_DIR/.env"

echo "DOTFILES_STATUS=installed" > .env
echo "LAST_DEST_DIR='$DEST_DIR'" >> .env

echo "done."
