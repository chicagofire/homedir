umask 002

export ENV=$HOME/.bashrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PAGER=/usr/bin/less
export EDITOR=vim
export SHELL=/bin/bash
export HISTFILE=~/.bash_history
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

# added by Anaconda 1.9.1 installer
export PATH="${HOME}/anaconda/bin:$PATH"

init_conda() {
    MINICONDA_HOME=$1
    echo -ne "\033[0;32mInitializing conda @ $MINICONDA_HOME via"
    

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$(${MINICONDA_HOME}/condabin/conda 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        echo -ne " hook\033[0m\n"
        eval "$__conda_setup"
    else
        if [ -f "${MINICONDA_HOME}/etc/profile.d/conda.sh" ]; then
            echo -ne " profile.d\033[0m\n"
            . "${MINICONDA_HOME}/etc/profile.d/conda.sh"
        else
            echo -ne " PATH\033[0m\n"
            export PATH="${MINICONDA_HOME}/condabin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}

if [[ -d ${HOME}/miniconda3 ]]; then
    init_conda ${HOME}/miniconda3
fi

# brew
if [[ -f /usr/local/Homebrew/completions/bash/brew ]]; then
    source /usr/local/Homebrew/completions/bash/brew
fi

# alacritty
if [[ "$TERM" = "alacritty" ]]; then
    export CLICOLOR=1
fi

if [ -f ~/.ssh/find-agent.sh ]; then
	. ~/.ssh/find-agent.sh
	if [ -z "$SSH_AUTH_SOCK" ]; then
		ssh_find_agent
	fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ -f /usr/local/bin/kitty ]]; then
    eval "$(kitty + complete setup bash)"
fi
