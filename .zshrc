# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# source "$HOME/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
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
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Theme configuration
ZSH_THEME="robbyrussell"

# Set to superior editing mode
export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

# Directories
export CODE="$HOME/code/"
export DOT="$HOME/dotfiles/"
export PRISM="$CODE/prism/"
export ZSHRC="$HOME/.zshrc"
export BACKEND="$PRISM/backend/"

# aliases
# Aliases for cd to Directories
alias code="cd $CODE"
alias dot="cd $DOT"
alias prism="cd $PRISM"
alias zshrcw="nvim $ZSHRC"
alias backend="cd $BACKEND"

#Alias for sourcing zshrc
alias zshrcs="source $HOME/.zshrc"

# Alias gor connecting and disconnecting bluetooth WFXM3
alias bluetooth="blueutil -p 1 && blueutil --connect 94-db-56-c1-9a-78"
alias bluetoothoff="blueutil --disconnect 94-db-56-c1-9a-78"

# prism scripts
alias dev="backend && ./scripts/dev.sh"
alias devd="backend && ./scripts/devd.sh"
alias devre="devd && dev"
alias cov="backend && ./scripts/code_coverage.sh"
alias test="backend && ./scripts/run_tests.sh"

alias vim='nvim'
alias c='clear'
alias charm='open -na "PyCharm.app"'
# docker
alias docker_sa='docker stop $(docker ps -q)'

# ls
alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias l.='ls -dl .*'

#fzf
alias fzf='fzf --preview="bat --color=always {} | head -500"'

# python
alias python="python3"
alias py="python"

# Kitty terminal aliases
alias icat="kitten icat"
alias s="kitten ssh"
alias d="kitten diff"


# macOS specific configurations
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Homebrew configuration
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        # Homebrew Python configuration
        export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"
    fi
fi

unalias cd 2>/dev/null
# Custom cd function
cd() {
    builtin cd "$@" && {
        clear
        ls -l
    }
}
