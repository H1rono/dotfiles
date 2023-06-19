# dotfiles

my dotfiles

## Environment

- MacBook Air (Apple M1 Sillicon)
    - OS: macOS Ventura 13
- Raspberry Pi 4B
    - OS: Raspberry Pi OS
- else
    - OS: Ubuntu Desktop 22.04

## Dependencies

- shell: [Zsh](https://www.zsh.org) ([GitHub mirror](https://github.com/zsh-users/zsh))
- terminal emulator: [WezTerm](https://wezfurlong.org/wezterm/) ([GitHub](https://github.com/wez/wezterm))
- Zsh plugin manager: [Sheldon](https://sheldon.cli.rs/) ([GitHub](https://github.com/rossmacarthur/sheldon))
    - [zsh-defer](https://github.com/romkatv/zsh-defer)
    - [rust-zsh-completions](https://github.com/ryutok/rust-zsh-completions)
    - [zsh-completions](https://github.com/zsh-users/zsh-completions)
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [wakatime-zsh-plugin](https://github.com/sobolevn/wakatime-zsh-plugin)
- prompt customizing: [Starship](https://starship.rs/) ([GitHub](https://github.com/starship/starship))
- terminal multiplexer: [tmux](https://github.com/tmux/tmux)
- tmux plugin manager: [tpm](https://github.com/tmux-plugins/tpm)
    - [odedlaz/tmux-onedark-theme](https://github.com/odedlaz/tmux-onedark-theme)
- editor in terminal: [Neovim](https://neovim.io/) ([GitHub](https://github.com/neovim/neovim))
- font: [FirgeNerd Console](https://github.com/yuru7/Firge)

Please see [manual installation of dependencies](#manual-installation-of-dependencies) to install above tools manually.

## About [gitmessage.txt](./config/git/gitmessage.txt)

This file is used for setting `git config --global commit.template`. There is my favorite list of [gitmoji](https://gitmoji.dev/).

## Files' descriptions

```
dotfiles
├── .gitignore              -- .gitignore
├── LICENSE                 -- GPL-3.0 license
├── README.md               -- this file
├── config
│   ├── git
│   │   └── gitmessage.txt  -- Git commit template
│   ├── nvim
│   │   └── init.vim        -- Neovim startup script
│   ├── sheldon
│   │   └── plugins.toml    -- Sheldon plugin information
│   └── starship.toml       -- Starship configuration
├── install.sh              -- install script of dotfiles
├── tmux.conf               -- tmux configuration
├── wezterm.lua             -- WezTerm configuration
└── zshrc                   -- Zsh startup script
```

## About `install.sh`

This script (currently) only makes or updates symbolic links from configuration files in this repository to corresponding ones in the specified directory (`$HOME` by default), and updates **global** git configuration.

If you want to make the links into `$HOME` directory, just run:

```bash
$ ./install.sh
```

If you want to make them into a specific directory, then:

```bash
# in absolute:
$ ./install.sh /path/to/dir
# or in relative:
$ ./install.sh ./some/dir
```

## Manual installation of dependencies

### in macOS

with [Homebrew](https://brew.sh/):

```bash
# install brew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install dependencies (zsh may be unnecessary)
$ brew install zsh sheldon starship tmux neovim
$ brew tap wez/wezterm
$ brew install --cask wez/wezterm/wezterm
```

### in Ubuntu(-like) OS

with [apt](https://wiki.debian.org/Apt) and [cargo](https://doc.rust-lang.org/cargo/):

```bash
# install zsh, tmux, and neovim
$ sudo apt install zsh tmux neovim
# install rust
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# install dependencies
$ cargo install sheldon starship
# install WezTerm (curl is required)
$ curl -LO https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
$ sudo apt-get install ./wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
$ rm ./wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
```

Since the commands above to install WezTerm works in only Ubuntu 22.04, please check [Linux installation](https://wezfurlong.org/wezterm/install/linux.html).

### general operation

This is required after OS-specific operation. To install tpm, run:

```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

To install FirgeNerd, please follow instructions below.

- download `FirgeNerd_[version].zip` file from [Releases · yuru7/Firge](https://github.com/yuru7/Firge/releases)
- unzip the zip file
- install `.ttf` files with font manager

### reference

- [zsh — Homebrew Formulae](https://formulae.brew.sh/formula/zsh)
- WezTerm
    - [macOS - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/install/macos.html)
    - [Linux - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/install/linux.html)
- [📦 Installation - sheldon docs](https://sheldon.cli.rs/Installation.html)
- [Starship#🚀-installation](https://starship.rs/guide/#%F0%9F%9A%80-installation)
- [Installing · tmux/tmux Wiki](https://github.com/tmux/tmux/wiki/Installing)
- [Installing Neovim · neovim/neovim Wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- [tmux-plugins/tpm: Tmux Plugin Manager#installation](https://github.com/tmux-plugins/tpm#installation)
- [Releases · yuru7/Firge](https://github.com/yuru7/Firge/releases)

## Article/link(s) about this repo

- [オレオレdotfilesを作った | 東京工業大学デジタル創作同好会traP](https://trap.jp/post/1737/)
