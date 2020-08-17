# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ $(grep Microsoft /proc/version) ]]; then
  # export Display for X11 Server (VcXsrv in my case) 
  DISPALY=:0
  export DISPALY
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# add command to history after execution
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

function getBranch { git branch 2>/dev/null | grep "^*" | colrm 1 2| awk '{print "["$0"]"}'; }

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\[\033[01;35m\]`getBranch`\[\033[00m\]> '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w`getBranch`> '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

 [ -f ~/.bash_aliases ] && . ~/.bash_aliases

 # fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/completions/fzf ] && source /usr/share/bash-completion/completions/fzf
[ -f ~/.config/fzf/fzf.conf ] && source ~/.config/fzf/fzf.conf