zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/x/nixos-dotfiles/home-manager/config/zsh/.zshrc'

compinit
SAVEHIST=1000
bindkey -e

eval "$(starship init zsh)"

ZINIT_HOME="/home/x/nixos-dotfiles/home-manager/config/zsh/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zinit cdreplay -q

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

HISTSIZE=5000
HISTFILE="/home/x/nixos-dotfiles/home-manager/config/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias ls="eza --icons"
alias ll="eza --icons -l"
alias la="eza --icons -la"
alias cat="bat"
alias vim='nvim'
alias clear='c'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

