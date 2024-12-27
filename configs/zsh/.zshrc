# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(
    git 
    vscode 
    docker
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# editor
export EDITOR="code"

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# options
setopt auto_cd
setopt multios
setopt share_history
setopt auto_pushd
setopt share_history

# activate plugins
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U compinit
compinit

# prompt
PROMPT='%F{blue}%~%f $(git_prompt_info)%# '