export PATH="$HOME/.local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

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

# esp-idf: nur bei Bedarf laden
function idf() {
  source $HOME/Second-Brain/Resources/esp-idf/export.sh
  idf "$@"
}

