export EDITOR=nvim

path+="/usr/local/sbin"
path+="/usr/local/bin"
path+="/usr/sbin"
path+="/usr/bin"
path+="/sbin"
path+="/bin"
path+="/snap/bin"
path+="/usr/games"
path+="$HOME/.local/bin"
path+="$HOME/.local/go/bin"
path+="$HOME/.local/flutter/bin"
export PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim=nvim

alias diskuse="df -ah | head -n 1 ; df -ah | tail -n +2 | sort -rhk 2 | head -n 10"
alias rcreload="source ~/.bashrc"
alias tmux-session-creator="tmux-session-creator /home/$USER/Workspace 1"
alias relxrdb="xrdb -merge ~/.Xresources"
alias screenshot="gnome-screenshot -acf /tmp/test && cat /tmp/test | xclip -i -selection clipboard -target image/png"

. "$HOME/.cargo/env"

alias luamake=/home/snitool/Workspace/lua-language-server/3rd/luamake/luamake

ZSH_THEME="agnoster"

plugins=(
  git
)

mkdir -p $HOME/.docs

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

alias gfp="git fetch ; git pull"
alias gadd="git add ."
alias gcm="git commit -m"
alias gss="git status -s"

alias note='nvim $HOME/.docs/$(date +"%Y%m%d").txt'
export DEFAULT_USER=$USER


# BEGIN SNIPPET: OVHcloud Web PaaS CLI configuration
HOME=${HOME:-$(echo '/home/'$USER)}
export PATH="$HOME/"'.webpaas-cli/bin':"$PATH"
if [ -f "$HOME/"'.webpaas-cli/shell-config.rc' ]; then . "$HOME/"'.webpaas-cli/shell-config.rc'; fi # END SNIPPET

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit
