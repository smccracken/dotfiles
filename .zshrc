# Make homebrew apps available on my path
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Add snippets
zinit snippet OMZP::git

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Customize prompt
if [ "$TERM_PROGRAM" != "Apple Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Automatically use Node version specified in .nvmrc
autoload -U add-zsh-hook

load_nvmrc() {
  if [ -f .nvmrc ]; then
    nvm use --silent
  fi
}

add-zsh-hook chpwd load_nvmrc
load_nvmrc  

# Aliases
alias ls='ls --color'
alias vim='nvim'

# aweb
alias awebapp='cd ~/Developer/accessible-web-application/web/'
alias awebext='cd ~/Developer/accessible-web-chrome-extension/'

ramp() {
  case $1 in
    bash)
      ~/Developer/accessible-web-application/scripts/local.sh bash
      ;;
    logs)
      docker logs -f ramp-web
      ;;
    start)
      ~/Developer/accessible-web-application/scripts/local.sh start
      ;;
    stop)
      ~/Developer/accessible-web-application/scripts/local.sh stop
      ;;
    restart)
      ~/Developer/accessible-web-application/scripts/local.sh restart
      ;;
    *)
      echo "Usage: ramp {start|stop|restart}"
      ;;
  esac
}
