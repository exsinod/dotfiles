# devlock prompt theme

prompt_devlock_help () {
  cat <<'EOF'

  prompt devlock [<color1> [<color2> [<color3> [<color4> [<color5>]]]]]

  defaults are red, cyan, green, yellow, and white, respectively.

EOF
}

prompt_devlock_setup () {
  local -a pcc
  local -A pc
  local p_userpwd p_end p_win

  autoload -Uz vcs_info

  pcc[1]=${1:-${${SSH_CLIENT+'yellow'}:-'red'}}
  pcc[2]=${2:-'cyan'}
  pcc[3]=${3:-'green'}
  pcc[4]=${4:-'yellow'}
  pcc[5]=${5:-'white'}

  pc['\[']="%F{$pcc[1]}["
  pc['\]']="%F{$pcc[1]}]"
  pc['<']="%F{$pcc[3]}<"
  pc['>']="%F{$pcc[3]}>"
  pc['\(']="%F{$pcc[1]}("
  pc['\)']="%F{$pcc[1]})"

  [[ -n "$WINDOW" ]] && p_win="$pc['\(']%F{$pcc[4]}$WINDOW$pc['\)']"

  p_userpwd="$pc['<']%F{$pcc[2]}%n@%m$p_win%F{$pcc[5]}:%F{$pcc[4]}%~$pc['>']"
  local p_vcs="%(2v.%U%2v%u.)"

  p_end="%f%B%#%b "

  typeset -ga zle_highlight
  zle_highlight[(r)default:*]=default:$pcc[2]

  prompt="$p_userpwd$p_vcs$p_end"
  PS2='%(4_.\.)%3_> %E'

  add-zsh-hook precmd prompt_devlock_precmd
  add-zsh-hook preexec prompt_devlock_preexec
}

prompt_devlock_precmd () {
  setopt noxtrace noksharrays localoptions
  local -a pcc
  local -A pc
  local exitstatus=$?
  local git_dir git_ref

  pcc[1]=${1:-${${SSH_CLIENT+'yellow'}:-'red'}}
  pcc[2]=${2:-'cyan'}
  pcc[3]=${3:-'green'}
  pcc[4]=${4:-'yellow'}
  pcc[5]=${5:-'white'}

  pc['\[']="%F{$pcc[1]}["
  pc['\]']="%F{$pcc[1]}]"
  pc['<']="%F{$pcc[3]}<"
  pc['>']="%F{$pcc[3]}>"
  pc['\(']="%F{$pcc[1]}("
  pc['\)']="%F{$pcc[1]})"

  psvar=()
  [[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" ||
	psvar[1]=""

  [[ -o interactive ]] && jobs -l

  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[2]="$vcs_info_msg_0_"
}

prompt_devlock_preexec () {
  setopt noxtrace noksharrays
  date
}

prompt_devlock_setup "$@"
