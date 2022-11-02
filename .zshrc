neofetch

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="jonathan"

plugins=(
    vi-mode
    kubectl
    jsontools
    git
    gitfast
)

source $ZSH/oh-my-zsh.sh

export GRADLE_USER_HOME=$HOME/.gradle

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export EDITOR='nvim'
export VISUAL='nvim'

export BROWSER=/usr/bin/google-chrome-stable
export CHROME_EXECUTABLE=$BROWSER

# Aliae
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

alias cdd="cd ~/Development/salespoint"
alias nva="nvim ~/.config/alacritty/alacritty.yml"
alias nvz="nvim ~/.zshrc"
alias nvv="nvim ~/.config/nvim/init.vim"
alias nvt="nvim ~/.tmux.conf"

alias ff="nvim \$(find . -type f | fzf --preview='head -$LINES {}')"
alias fd="cd \$(find . -type d | fzf --preview='head -$LINES {}')"

alias gst="git status"
alias gca="git commit --amend"
alias gpull="git pull origin"
alias gpush="git push origin"

# dotfiles
alias c='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cs="c status"
alias cpull="c pull origin"
alias cpush="c push origin"
alias cadd='c ls-files | while read -r i; do c add "$i"; done'
alias caddunknown='cs | grep "modified:.*" | tr -s " " | cut -d " " -f 2 | xargs -I % -t git --git-dir=$HOME/.cfg/ --work-tree=$HOME add %'

alias imageToClipboard='xclip -selection clipboard -target image/png -i '

alias mci="./mvnw clean install"
alias mcis="./mvnw clean install -DskipTests"

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

alias startwork="cd $HOME/code/work && tmux"

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

precmd() { print "" }

source /usr/share/nvm/init-nvm.sh

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/flutter/bin

export NEXUS_NPM_TOKEN=NpmToken.f9e5f6a8-f850-3a5b-a89b-ac5ff8b33c54

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
