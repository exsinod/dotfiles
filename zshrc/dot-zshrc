source $HOME/.zprofile

export GRADLE_USER_HOME=$HOME/.gradle

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_DIRS=/usr/share

export EDITOR='nvim'
export VISUAL='nvim'

export PATH="$PATH:/home/devlock/.local/bin"
export PATH=$PATH:$HOME/devtools/jdt-language-server-1.9.0/bin/
export PATH=$PATH:$HOME/devtools
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin
export PATH=$PATH:$HOME/.local/share/nvim/mason/packages/bash-language-server/node_modules/.bin

# Aliae

alias vim="filepath=\$(FZF_DEFAULT_COMMAND='fd --type=f --hidden --strip-cwd-prefix --exclude .git' fzf); cd \$(dirname \$filepath) && nvim \$(basename \$filepath)"
alias vimd="FZF_DEFAULT_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git' && cd \$(fzf)"
alias nva="nvim ~/.config/alacritty/alacritty.toml"
alias nvz="nvim ~/.zshrc"
alias nvv="nvim ~/.config/nvim/init.lua"
alias nvt="nvim ~/.tmux.conf"

alias ls="eza -l --git"

alias gst="git status"
alias gpull="git pull origin"
alias gpush="git push origin"
alias glog1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias glog2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias glog=glog1

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

alias start_conda='eval "$(/home/sven/devtools/miniconda3/bin/conda shell.zsh hook)"'
alias dk="docker-compose"
alias dkup="dk up"
alias dkupd="dkup -d"
alias dkdown="dk down -v"
alias dks="dk scale"
alias dkl="dk logs -f"

alias dps="docker ps"

function drm() {
    docker rm $1
    docker rmi $1
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

# Init Starship
eval "$(starship init zsh)"

# Set up fzf key bindings for zsh
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'exa --tree --color=always {} | head -200'"

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)             fzf --preview 'exa --tree --color=always {} | head -200'                "$@" ;;
        export|unset)   fzf --preview "eval 'echo \${}'"                                       "$@" ;;
        ssh)            fzf --preview 'dig {}'                                                  "$@" ;;
        *)              fzf --preview 'bat -n --color=always --line-range :500 {}'  "$@" ;;
    esac
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sven/devtools/google-cloud-sdk/path.zsh.inc' ]; then . '/home/sven/devtools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sven/devtools/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/sven/devtools/google-cloud-sdk/completion.zsh.inc'; fi
