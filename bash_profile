echo "Loading ~/.bash_profile because daniela is the coolest"
echo "Logged in as $USER at $(hostname)"

[[ -r ~/.bashrc ]] && . ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home
export PATH=./bin:./script:$HOME/.nodenv/shims:$HOME/.dotfiles/bin:$HOME/.rbenv/shims:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Cellar/rabbitmq/3.7.3/sbin:/Users/daschi/Desktop/projects/nand2tetris/tools:$JAVA_HOME:$PATH
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Users/daschi/Library/Python/3.7/bin"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:/Users/daschi/Library/Python/3.7/bin/pipenv:${PATH}"
export PATH
