echo "Loading ~/.bash_profile because daniela is the coolest"
echo "Logged in as $USER at $(hostname)"

[[ -r ~/.bashrc ]] && . ~/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home
export PATH=./bin:./script:$HOME/.nodenv/shims:$HOME/.dotfiles/bin:$HOME/.rbenv/shims:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Cellar/rabbitmq/3.7.3/sbin:/usr/local/Cellar/postgresql/11.1_1/bin/:$JAVA_HOME:$PATH

# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
