#!/bin/bash

__FILE__="${BASH_SOURCE[0]}"
[[ -L "$__FILE__" ]] && __FILE__=$(readlink "$__FILE__")
export DOTFILES="$( cd "$( dirname "${__FILE__}" )" && pwd )"

# Turns the Meta Key on
set meta-flag on
set input-meta on
set output-meta on
set convert-meta off
shift;shift; # I have no idea what set seems to append it args to $*, weird.

export HISTCONTROL=erasedups
export HISTSIZE=100000
shopt -s cmdhist
shopt -s histappend # this ensures history is written
shopt -s lithist
bind "set completion-ignore-case on" # ignore care on tab completion in bash
bind 'set match-hidden-files off' # doesnt tab complete hidden files like .svn files

# export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# this is for npm
export PKG_CONFIG_PATH=/usr/X11/lib/pkgconfig


export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh
export PROMPT_COLOR=34
export PS1='\[\033[4;1;${PROMPT_COLOR}m\]\w\[\033[0m\]$(unalias git; __git_ps1 " $(git config --get user.email) (%s)") \n☃ '

export EDITOR='subl'
export GIT_EDITOR='subl -w'

export PATH="./bin:./script:$DOTFILES/bin:$PATH"

source "${DOTFILES}/aliases"

export SELENIUM=true

# docker
# source /usr/local/etc/bash_completion.d/docker
# eval "$(boot2docker shellinit)"
# source /usr/local/etc/bash_completion.d/docker-compose
