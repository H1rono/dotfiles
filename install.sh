#!/bin/bash

src=$(pwd)
dest="${1:-$HOME}"

echo "install dotfiles from \`$src\` into \`$dest\` ..."

function setlink() {
	local src="$1"
	local dest="$2"
	if [ -e "$dest" ]; then
		echo "found \`$dest\`, move it into \`$dest.old\`"
		mv "$dest" "$dest.old"
	fi
	echo "create a symbolic link to \`$src\` at \`$dest\`"
	ln -s "$src" "$dest"
}

setlink "$src/zshrc" "$dest/.zshrc"
setlink "$src/wezterm.lua" "$dest/.wezterm.lua"
echo "mkdir -p \"$dest/.config\""
mkdir -p "$dest/.config"
setlink "$src/starship.toml" "$dest/.config/starship.toml"
echo "mkdir -p \"$dest/.config/nvim\""
mkdir -p "$dest/.config/nvim"
setlink "$src/nvim/init.vim" "$dest/.config/nvim/init.vim"
echo "mkdir -p \"$dest/.config/sheldon\""
mkdir -p "$dest/.config/sheldon"
setlink "$src/sheldon/plugins.toml" "$dest/.config/sheldon/plugins.toml"

echo "done."

