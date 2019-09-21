current_branch() {
  git branch 2>&1 | awk '/^[*]/ { print "(" $2 ")" }'
}

count_changed_files() {
  git status --porcelain 2>&1 | grep -v '^fatal' | wc -l | awk '/^[^0]/'
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

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=vim
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

generate_ps1
