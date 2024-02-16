# dotfiles

my dotfiles

## Environments

### With Home Manager

- MacBook Air (Apple M1 Sillicon)
    - OS: macOS Sonoma 14

### Without Home Manager

- MacBook Air (Apple M1 Sillicon)
    - OS: macOS Sonoma 14
- Raspberry Pi 4B
    - OS: Raspberry Pi OS
- else
    - OS: Ubuntu Desktop 22.04

## Dependencies

- [Home Manager](https://nix-community.github.io/home-manager/) ([GitHub](https://github.com/nix-community/home-manager)) (optional)
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
- programming languages/tools manager: [mise](https://mise.jdx.dev) ([GitHub](https://github.com/jdx/mise))
    - managed languages/tools:
        [Go](https://go.dev), [Python](https://www.python.org), [NodeJS](https://nodejs.org/en),
        [Deno](https://deno.com), [rye](https://rye-up.com)
- modern CLI tools
    - [jq](https://jqlang.github.io/jq/) ([GitHub](https://github.com/jqlang/jq))
    - [fzf](https://github.com/junegunn/fzf)
    - [bat](https://github.com/sharkdp/bat)
    - [zoxide](https://github.com/ajeetdsouza/zoxide)
    - [lsd](https://github.com/lsd-rs/lsd)
    - [gh](https://cli.github.com) ([GitHub](https://github.com/cli/cli))
    - [dust](https://github.com/bootandy/dust)
- [rustup](https://rustup.rs) (optional)
    - Required if setupping without Home Manager
- [cargo](https://doc.rust-lang.org/cargo/)
    - subcommands:
        [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all)
- terminal multiplexer: [tmux](https://github.com/tmux/tmux)
- tmux plugin manager: [tpm](https://github.com/tmux-plugins/tpm)
    - [odedlaz/tmux-onedark-theme](https://github.com/odedlaz/tmux-onedark-theme)
- editor in terminal: [Neovim](https://neovim.io/) ([GitHub](https://github.com/neovim/neovim))
- font: [FirgeNerd Console](https://github.com/yuru7/Firge)

Please see [manual installation of dependencies](#manual-installation-of-dependencies) to install above tools manually.

## Files' descriptions

```
dotfiles
├── .github
│   ├── dependabot.yml        -- Dependabot configuration file
│   └── workflows
│       ├── home-manager.yml  -- GitHub Actions to check home-manager build
│       └── update-flake.yml  -- GitHub Actions to update flake.lock automatically
├── .gitignore                -- .gitignore
├── config                    -- ~/.config
│   ├── bat
│   │   └── config.conf       -- default options of `bat`
│   ├── git
│   │   └── gitmessage.txt    -- Git commit template
│   ├── mise
│   │   └── config.toml       -- mise global configuration
│   ├── nvim
│   │   └── init.vim          -- Neovim startup script
│   ├── sheldon
│   │   └── plugins.toml      -- Sheldon plugin information
│   └── starship.toml         -- Starship configuration
├── flake.lock                -- lockfile of flake.nix
├── flake.nix                 -- entrypoint of Nix Flakes
├── home.nix                  -- configuration body of home-manager
├── install.sh                -- install script of dotfiles
├── LICENSE                   -- GPL-3.0 licence
├── nix                       -- Nix helper functions
│   ├── fetchFlakeInput.nix
│   ├── readFlakeLock.nix
│   └── readInputInfo.nix
├── packages
│   ├── cargo-clean-all.nix   -- Nix package file to install cargo-clean-all
│   ├── firge-nerd.nix        -- Nix package file to install FirgeNerd Console
│   ├── mise.nix              -- Nix package file to install mise
│   └── sheldon.nix           -- Nix package file to install Sheldon
├── README.md                 -- this file
├── rust-toolchain.toml       -- information of rust toolchain
├── rye
│   └── config.toml           -- rye configuration file
├── tmux.conf                 -- tmux configuration
├── wezterm.lua               -- WezTerm configuration
└── zshrc                     -- Zsh startup script
```

## About [`gitmessage.txt`](./config/git/gitmessage.txt)

This file is used for setting `git config --global commit.template`. There is my favorite list of [gitmoji](https://gitmoji.dev/).

## About [`rust-toolchain.toml`](./rust-toolchain.toml)

This file is currently used by home-manager (with [fenix](https://github.com/nix-community/fenix)), to determine what version of rust is to be installed. Its layout follows [Overrides - The rustup book #The toolchain file](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file), which is used for per-directory overrides with rustup.

With rustup, same setup with this file is done by running:

```bash
# $TOOLCHAIN_CHANNEL corresponds to `channel = ...` in the file
$ rustup default $TOOLCHAIN_CHANNEL
# for each element of `components = [...]` in the file (bound to $COMPONENT)
$ rustup component add $COMPONENT
```

## About [`install.sh`](./install.sh)

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

## Quick installation

This requires [Nix](https://nixos.org) and [Home Manager](https://nix-community.github.io/home-manager/) are installed. With these commands, you don't have to follow [Manual installation](#manual-installation-of-dependencies) below.

```bash
$ nix run nixpkgs#gnused -- -i -e "s/kh/$USER/" /path/to/dotfiles/flake.nix
$ home-manager switch --flake /path/to/dotfiles
```

**warning**: this way is only tested in M1 MacBook Air (system `aarch64-darwin`).

ref:

- [nix-systems/current-system: Like `builtins.currentSystem` but for the CLI](https://github.com/nix-systems/current-system)

## Manual installation of dependencies

> [!NOTE]
> [gh](https://cli.github.com), [dust](https://github.com/bootandy/dust), and [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all)
> are not included in the commands below. This issue will be fixed soon.

### in macOS

with [Homebrew](https://brew.sh/):

```bash
# install brew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install dependencies (zsh may be unnecessary)
$ brew install zsh sheldon starship tmux neovim mise bat zoxide jq fzf
$ brew tap wez/wezterm
$ brew install --cask wez/wezterm/wezterm
```

see also [general operation](#general-operation) below.

### in Ubuntu(-like) OS

with [apt](https://wiki.debian.org/Apt) and [cargo](https://doc.rust-lang.org/cargo/):

```bash
# requirements to complete installation
$ sudo apt install libssl-dev pkg-config build-essential cmake
# install rust (you may need to restart shell)
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# install with apt
$ sudo apt install zsh tmux neovim bat lsd zoxide jq fzf
# install with `cargo install`
$ cargo install sheldon starship mise
# install WezTerm (curl is required)
$ curl -LO https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
$ sudo apt-get install ./wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
$ rm ./wezterm-20230408-112425-69ae8472.Ubuntu22.04.deb
```

> [!WARNING]
> Since the commands above to install WezTerm only works in Ubuntu 22.04, please check [Linux installation](https://wezfurlong.org/wezterm/install/linux.html).

see also [general operation](#general-operation) below.

### general operation

This is required after OS-specific operation. To install tpm, run:

```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

To activate mise, run:

```bash
$ /path/to/dotfiles/install.sh  # if you haven't run `install.sh`
$ mise trust ~/.config/mise/config.toml
$ mise install
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
- [sharkdp/bat: A cat(1) clone with wings. #Installation](https://github.com/sharkdp/bat?tab=readme-ov-file#installation)
- [lsd-rs/lsd: The next gen ls command #Installation](https://github.com/lsd-rs/lsd?tab=readme-ov-file#installation)
- [Getting Started | mise-en-place](https://mise.jdx.dev/getting-started.html)
- [ajeetdsouza/zoxide: A smarter cd command. Supports all major shells. #Installation](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
- [Installing · tmux/tmux Wiki](https://github.com/tmux/tmux/wiki/Installing)
- [Installing Neovim · neovim/neovim Wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- [tmux-plugins/tpm: Tmux Plugin Manager#installation](https://github.com/tmux-plugins/tpm#installation)
- [Releases · yuru7/Firge](https://github.com/yuru7/Firge/releases)

## Article/link(s) about this repo

- [オレオレdotfilesを作った | 東京工業大学デジタル創作同好会traP](https://trap.jp/post/1737/)
