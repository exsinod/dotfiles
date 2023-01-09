# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dieter"

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

alias cdd="cd ~/Development/salespoint"
alias nva="nvim ~/.config/alacritty/alacritty.yml"
alias nvz="nvim ~/.zshrc"
alias nvv="nvim ~/.config/nvim/init.vim"
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

alias awsnonprod="kubectl config set-context arn:aws:eks:eu-west-1:137505996109:cluster/shared-non-prod-1"
alias awsprod="kubectl config set-context arn:aws:eks:eu-west-1:003253549466:cluster/shared-prod-1"

alias dk="docker-compose"
alias dkup="dk up"
alias dkupd="dkup -d"
alias dkdown="dk down -v"
alias dks="dk scale"
alias dkl="dk logs -f"

function decodeBase64() {
  echo $1 | base64 -D
}

function dockerClean() {
  docker rm $(docker ps -a -q)
  # Delete all images
  docker rmi $1 $(docker images -q)
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/bin/flutter/bin:$PATH
export NEXUS_NPM_TOKEN=NpmToken.f9e5f6a8-f850-3a5b-a89b-ac5ff8b33c54

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sinod/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sinod/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sinod/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sinod/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
