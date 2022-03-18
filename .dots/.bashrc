#### helpers
update() {
    printf -- "\n\n> trying to execute: sudo apt-get upgrade -y ; sudo apt-get update -y \n\n"

    sudo apt-get upgrade -y ; sudo apt-get update -y
}

#### PS1
current_branch() {
  git branch 2>&1 | awk '/^[*]/ { print "(" $2 ")" }'
}

count_changed_files() {
  git status &> /dev/null
  if [ $? -eq 0 ]; then 
    git status --porcelain | wc -l | awk '/^[^0]/'
  fi
}

generate_ps1() {
    local _branch='\[\033[01;94m\]$(current_branch | sed "s/^//" | sed "s/$/ /" )\[\033[0m\]'
    local _changes='\[\033[01;93m\]$(count_changed_files | sed "s/$/ changes /")\[\033[0m\]'
    local _pwd='\[\033[01;37m\]\w\[\033[0m\]'
    local _arrow='\[\033[01;91m\]~>\[\033[0m\]'

    export PS1=$(echo ${_branch}${_changes}${_pwd} ${_arrow}' ')
}

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# essentials
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim=nvim

# tools
alias diskuse="df -ah | head -n 1 ; df -ah | tail -n +2 | sort -rhk 2 | head -n 10"
alias rcreload="source ~/.bashrc"
alias tmux-session-creator="tmux-session-creator /home/$USER/Workspace 2"
alias relxrdb="xrdb -merge ~/.Xresources"
alias screenshot="gnome-screenshot -acf /tmp/test && cat /tmp/test | xclip -i -selection clipboard -target image/png"

# git
alias gfp="git fetch ; git pull"
alias gadd="git add ."
alias gcm="git commit -m"
alias gss="git status -s"

export EDITOR=vim
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/games:$HOME/.local/bin:$PATH

generate_ps1

. "$HOME/.cargo/env"
