#
# Executes commands at the start of an interactive session.
#

if [[ -s /etc/profile ]]; then
  source /etc/profile
fi

if [[ -s "${ZDOTDIR:-$HOME}/.platform" ]]; then
  source "${ZDOTDIR:-$HOME}/.platform"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.aliases" ]]; then
  source "${ZDOTDIR:-$HOME}/.aliases"
fi

if [[ -s "${ZDOTDIR:-$HOME}/.path" ]]; then
  source "${ZDOTDIR:-$HOME}/.path"
fi

export PATH=~/local/bin:~/local/sbin:$PATH

if [[ -d "${ZDOTDIR:-$HOME}/.z" ]]; then
  export _Z_DATA="${ZDOTDIR:-$HOME}/.zdata"
  source "${ZDOTDIR:-$HOME}/.z/z.sh"
fi

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins "$key_info[Control]A" beginning-of-line
bindkey -M vicmd "$key_info[Control]A" beginning-of-line
bindkey -M viins "$key_info[Control]E" end-of-line
bindkey -M vicmd "$key_info[Control]E" end-of-line

