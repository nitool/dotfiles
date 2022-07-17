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
export PATH

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

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

alias gfp="git fetch ; git pull"
alias gadd="git add ."
alias gcm="git commit -m"
alias gss="git status -s"
