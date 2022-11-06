# dotfiles

my dotfiles

## tested environment(s)

- MacBook Air (Apple M1 Sillicon)
    - OS: Ventura 13.0
- Raspberry Pi 4B
    - OS: Raspberry Pi OS

## software structure

- version manager: [asdf](https://asdf-vm.com/)
- shell: [Zsh](https://www.zsh.org)
- terminal emulator: [WezTerm](https://wezfurlong.org/wezterm/)([GitHub](https://github.com/wez/wezterm))
- Zsh plugin manager: [Sheldon](https://github.com/rossmacarthur/sheldon)
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- prompt customizing: [Starship](https://starship.rs/ja-jp/)
- editor: [Neovim](https://neovim.io/)

## files' descriptions

```
dotfiles
├── install.sh        -- install script of dotfiles, tested only in Raspberry Pi
├── LICENSE           -- GPL-3.0 license
├── README.md         -- this file
├── nvim
│   └── init.vim      -- Neovim startup script
├── sheldon
│   └── plugins.toml  -- Sheldon plugin information
├── starship.toml     -- Starship configuration
├── tool-versions     -- asdf version information
├── wezterm.lua       -- WezTerm configuration
└── zshrc             -- Zsh startup script
```
