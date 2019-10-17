echo "Loading ~/.bash_profile because daniela is the coolest"
echo "Logged in as $USER at $(hostname)"

[[ -r ~/.bashrc ]] && . ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PYTHONPATH=/Users/daschi/Desktop/ESH/hobbes/transformations/dependencies/python
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home
export PATH=./bin:./script:$HOME/.nodenv/shims:$HOME/.dotfiles/bin:$HOME/.rbenv/shims:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Cellar/rabbitmq/3.7.3/sbin:/usr/local/Cellar/postgresql/11.1_1/bin/:/Users/daschi/Desktop/ESH/hobbes/cli/dist:/Users/daschi/Desktop/projects/nand2tetris/tools:$JAVA_HOME:$PATH
