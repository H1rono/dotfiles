# config of zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions#configuration
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# sheldon loading
eval "$(sheldon source)"

# config of zsh history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=2000
setopt hist_ignore_dups

# cd config
setopt AUTO_CD

# less colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# edit MANPATH for home-manager
if [ -d "$HOME/.nix-profile/share/man" ] ; then
    export MANPATH="$HOME/.nix-profile/share/man:$MANPATH"
fi
