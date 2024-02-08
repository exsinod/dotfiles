# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="rgm" # set by `omz`

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export GRADLE_USER_HOME=$HOME/.gradle

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export EDITOR='nvim'
export VISUAL='nvim'

# Aliae

alias ls="exa -lla"

alias nva="nvim ~/.config/alacritty/alacritty.yml"
alias nvz="nvim ~/.zshrc"
alias nvv="nvim ~/.config/nvim/init.lua"
alias nvt="nvim ~/.tmux.conf"

alias ff="nvim \$(find . -type f | fzf --preview='head -$LINES {}')"
alias fd="cd \$(find . -type d | fzf --preview='head -$LINES {}')"

alias gs="git status"
alias gpull="git pull origin"
alias gpush="git push origin"

alias c='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="c status"
alias cpull="c pull origin"
alias cpush="c push origin"
alias caddall='c ls-files | while read -r i; do c add "$i"; done'

alias mci="mvn clean install"
alias mcis="mvn clean install -DskipTests"

alias g="./gradlew"
alias gcb="g clean build"
alias gcbt="g clean build -x test"
alias gcbtp="g clean build -x test -x pmdMain -x pmdTest"
alias gc="g clean"

alias dk="docker-compose"
alias dkup="dk up"
alias dkupd="dkup -d"
alias dkdown="dk down -v"
alias dks="dk scale"
alias dkl="dk logs -f"

function dockerClean() {
  docker rm $(docker ps -a -q)
  # Delete all images
  docker rmi $1 $(docker images -q)
  docker system prune
  docker network prune
  docker volume prune
}

function dklogs() {
  docker ps | grep $1 | cut -d ' ' -f 1 | xargs docker logs -f
}

function getDockerId() {
  docker ps | grep $1 | awk '{print $1;}'
}

function dkexec() {
	docker exec -it `getDockerId $1` $2
}

function dkill() {
  docker kill `getDockerId $1`
}

export DOCKER_DEFAULT_PLATFORM=linux/amd64

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NEXUS_USERNAME=lab-builduser
export NEXUS_PASSWORD=iuK7CRfiYpJ7Hhxyauqi

eval "$(/opt/homebrew/bin/brew shellenv)"

# python
export PATH="$(pyenv root)/shims:${PATH}"
pyenv global 2.7.18 3.10

export PATH=$HOME/developer/flutter/bin:$HOME/.pub-cache/bin:$HOME/developer/nvim-macos/bin:$PATH
export NEXUS_NPM_TOKEN=NpmToken.f9e5f6a8-f850-3a5b-a89b-ac5ff8b33c54
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
