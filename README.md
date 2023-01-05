# dotfiles

my dotfiles

## tested devices

- MacBook Air (Apple M1 Sillicon)
    - OS: Ventura 13.0
- Raspberry Pi 4B
    - OS: Raspberry Pi OS

## environment

- shell: [Zsh](https://www.zsh.org)
- terminal emulator: [WezTerm](https://wezfurlong.org/wezterm/) ([GitHub](https://github.com/wez/wezterm))
- Zsh plugin manager: [Sheldon](https://sheldon.cli.rs/) ([GitHub](https://github.com/rossmacarthur/sheldon))
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- prompt customizing: [Starship](https://starship.rs/) ([GitHub](https://github.com/starship/starship))
- terminal multiplexer: [tmux](https://github.com/tmux/tmux)
- tmux plugin manager: [tpm](https://github.com/tmux-plugins/tpm)
    - [odedlaz/tmux-onedark-theme](https://github.com/odedlaz/tmux-onedark-theme)
- editor in terminal: [Neovim](https://neovim.io/)
- font: [FirgeNerd Console](https://github.com/yuru7/Firge)

## files' descriptions

```
dotfiles                  -- .gitignore
├── .gitignore
├── LICENSE               -- GPL-3.0 license
├── README.md             -- this file
├── config
│   ├── nvim
│   │   └── init.vim      -- Neovim startup script
│   ├── sheldon
│   │   └── plugins.toml  -- Sheldon plugin information
│   └── starship.toml     -- Starship configuration
├── install.sh            -- install script of dotfiles
├── tmux.conf             -- tmux configuration
├── wezterm.lua           -- WezTerm configuration
└── zshrc                 -- Zsh startup script
```

## Article/link(s) about this repo

- [オレオレdotfilesを作った | 東京工業大学デジタル創作同好会traP](https://trap.jp/post/1737/)
