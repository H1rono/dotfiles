#!/bin/bash

src=$(pwd)
dest="${1:-$HOME}"

echo "install dotfiles from \`$src\` into \`$dest\` ..."

function install() {
	local src="$1"
	local dest="$2"
	if [ -e "$dest" ]; then
		echo "found \`$dest\`, move it into \`$dest.old\`"
		mv "$dest" "$dest.old"
	fi
	echo "create a symbolic link to \`$src\` at \`$dest\`"
	ln -s "$src" "$dest"
}

install "$src/zshrc" "$dest/.zshrc"
install "$src/wezterm.lua" "$dest/.wezterm.lua"
install "$src/tool-versions" "$dest/.tool-versions"
echo "mkdir -p \"$dest/.config\""
mkdir -p "$dest/.config"
install "$src/starship.toml" "$dest/.config/starship.toml"
echo "mkdir -p \"$dest/.config/nvim\""
mkdir -p "$dest/.config/nvim"
install "$src/nvim/init.vim" "$dest/.config/nvim/init.vim"
echo "mkdir -p \"$dest/.config/sheldon\""
mkdir -p "$dest/.config/sheldon"
install "$src/sheldon/plugins.toml" "$dest/.config/sheldon/plugins.toml"

echo "done."

