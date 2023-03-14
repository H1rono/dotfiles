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
