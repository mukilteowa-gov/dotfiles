# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


##### Core env
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

##### Zsh options
HISTFILE="$HOME/.zsh_history"; HISTSIZE=5000; SAVEHIST=5000; HISTDUP=erase
setopt EXTENDED_HISTORY INC_APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY
setopt AUTO_CD NO_BEEP
bindkey -e

##### Completion
autoload -Uz compinit
ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
compinit -d "$ZSH_COMPDUMP"

##### Aliases
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

export EDITOR="nvim"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippits
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# load completions
autoload -U compinit && compinit -d "${ZSH_COMPDUMP}"
### End of Zinit's installer chunk

# Load completions
autoload cdreplay -q

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{A-Z}={a-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide:*' fzf-preview 'zoxide query --list --format json | jq -r ".[] | \"\(.path)\t\(.score)\"" | sort -k2 -nr | cut -f1'

# Shell integrations
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
if [[ -n $ZSH_VERSION && $- == *i* ]]; then
  eval "$(zoxide init zsh --cmd cd)"
fi
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
