#### helpers
update() {
    printf -- "\n\n> trying to execute: sudo apt-get upgrade -y ; sudo apt-get update -y \n\n"

    sudo apt-get upgrade -y ; sudo apt-get update -y
}

remove_containers() {
    printf -- "\n\n> trying to remove containers \n\n"

    docker container rm -f $(docker container ls -aq)
}

remove_volumes() {
    printf -- "\n\n> trying to remove volumes \n\n"

    docker volume rm $(docker volume ls -q)
}

stop_containers() {
    printf -- "\n\n> trying to stop containers \n\n"

    docker container stop $(docker container ls -aq)
}

cleanup_docker_heavy_stack() {
    remove_containers
    remove_volumes
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

#### setup
# $1 - recursive path, can be null
generate_workspace_aliases() {
    local _path="/home/${USER}/Workspace"

    if ! [[ -z $1 ]]; then
        _path=$1
    fi

    for entry in $(ls -lA ${_path} | tail -n +2 | awk '{print $NF}')
    do
        local _entry_path=$(echo ${_path}'/'${entry})

        if [[ -d ${_entry_path} ]] && [[ -z $1 ]]; then
            generate_workspace_aliases ${_entry_path}
        else
            local _alias=$(echo ${_entry_path} | sed -r 's/^.*?[/]([^/]+?)[/]([^/]+?)$/\1-\2/')
            alias $(echo 'work-'${_alias,,})="cd ${_entry_path}"
        fi
    done
}

setup() {
    local _workspace_path="/home/${USER}/Workspace"

    generate_ps1

    if ! [[ -d  ${_workspace_path} ]]; then
        mkdir ${_workspace_path}
    fi

    if ! [[ -d ${_workspace_path}/priv ]]; then
        mkdir ${_workspace_path}/priv
    fi

    generate_workspace_aliases
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
alias gitpull="git fetch ; git pull"
alias diskuse="df -ah | head -n 1 ; df -ah | tail -n +2 | sort -rhk 2 | head -n 10"
alias rcreload="source ~/.bashrc"
alias vim=nvim

export EDITOR=vim
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/games:$HOME/.local/bin:$PATH

setup

