export PATH="$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

plugins=(
    git
    docker
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# editor
export EDITOR="nvim"

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# options
setopt auto_cd
setopt multios
setopt share_history
setopt auto_pushd
setopt hist_ignore_dups
setopt hist_ignore_space

# fzf – Fuzzy Finder (Ctrl+R History, Ctrl+T Dateien, Alt+C Verzeichnis)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi --height 40% --border rounded"

# zoxide – smartes cd
eval "$(zoxide init zsh)"
alias cd="z"

# eza – modernes ls
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --git --group-directories-first"
alias lt="eza --tree --icons --level=2"

# bat – modernes cat
alias cat="bat --style=plain --paging=never"

# Starship Prompt
eval "$(starship init zsh)"

# esp-idf: nur bei Bedarf laden
function idf() {
  source $HOME/Second-Brain/Resources/esp-idf/export.sh
  unfunction idf
  idf.py "$@"
}

