eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"

export PATH=$PATH:/usr/local/go/bin:/home/parallels/.cargo/bin

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

#. "$HOME/.asdf/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
export LS_COLORS="$(vivid generate catppuccin-mocha)"

alias ls='eza -al --git --icons=always --color=always'
alias vim='nvim'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
