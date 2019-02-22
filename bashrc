#!/bin/bash

echo 'bash_rc file!'
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
export PKG_CONFIG_PATH=/usr/local/opt/postgresql@9.6/lib/pkgconfig

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT_COMMAND=$PROMPT_COMMAND' PS1="${c_path}\W ${c_reset}$(git_prompt)${c_time}\D{%T}${c_reset} :> "'

export PS1='\n\[\033[0;31m\]\W\[\033[0m\]$(git_prompt)\[\033[0m\]:> '

# A more colorful prompt
# \[\e[0;36m\] sets the color to white
c_time='\[\e[1;37m\]'
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;34m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

reset_assets() {
  echo "Clearing rails cache"
  bundle exec rake cache:clear
  echo "Generating react_bundle"
  npm run build
  echo "Clobber assets and precompile"
  bundle exec rake assets:clobber assets:precompile
}

new_struct() {
  echo "Dropping and reseting pharoah test db from scratch"
  bin/rails app:db:environment:set RAILS_ENV=test
  RAILS_ENV='test' bundle exec rake app:db_ecto:drop app:db_ecto:create

  echo 'Loading Structure File running tests before migrating'
  RAILS_ENV='test' bundle exec rake app:db_ecto:structure:load

  echo 'Running Migrations'
  RAILS_ENV='test' bundle exec rake app:db_ecto:migrate

  echo "Changing WITH NO DATA, to WITH DATA"
  sed -i -e 's/WITH NO DATA/WITH DATA/g' db_ecto/structure.sql

  echo "Changing the search path for the fy2017 endpoints for PostGIS"
  sed -i -e 's/search_path = endpoint, pg_catalog/search_path = endpoint, public, pg_catalog/g' db_ecto/structure.sql

  echo "Deleting idle_in_transaction_session_timeout line in structure.sql"
  sed -i '' '/SET idle_in_transaction_session_timeout = 0;/d;' db_ecto/structure.sql

  echo "Running tests for the last time"
  RAILS_ENV='test' bundle exec rspec

  echo "Running rubocop"
  bundle exec rubocop -a

  rm db_ecto/structure.sql-e #this file randomly gets created so I delete it

  echo "Should have a FILE with a better structure then
        Cillian Murphys cheek bones"

}

tweak() {
  git add .
  git ci --amend -C HEAD
}

fork_db() {
  echo "WARNING! You are about to fork the production database and hook it up"
  echo "to '$1'"
  echo "If you want to continue, enter again the name of the review app"
  read review_app_name
  echo
  if [ "$review_app_name" "==" "$1" ]; then
    heroku addons:create heroku-postgresql:standard-0 --fork `heroku pg:credentials DATABASE -a irt-v3-production | grep 'postgres[-\.\/\w:@]*'` -a $1 | grep 'HEROKU_POSTGRESQL_[A-Z]*' | sed 's/Created post.* //' | sed 's/_URL//' | xargs -I % heroku pg:promote % -a $1
    sleep 45
    heroku pg:wait -a $1
    heroku run rake db:migrate -a $1
    heroku run rake db_ecto:migrate -a $1
    heroku pg:credentials DATABASE -a $1
  else
    echo "Aborted"
  fi
}

export EDITOR='atom'
export GIT_EDITOR='atom -w'

export PATH="./bin:./script:$DOTFILES/bin:/usr/local/bin:$PATH"

source "${DOTFILES}/aliases"
source "${DOTFILES}/.aliases"

export SELENIUM=true

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex

# Force grep to always use the color option and show line numbers
# export GREP_OPTIONS='--color=always'

# docker
# source /usr/local/etc/bash_completion.d/docker
# eval "$(boot2docker shellinit)"
# source /usr/local/etc/bash_completion.d/docker-compose
