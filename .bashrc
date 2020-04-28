umask 002

export ENV=$HOME/.bashrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PAGER=/usr/bin/less
export EDITOR=vim
export SHELL=/bin/bash
export HISTFILE=~/.bash_history

# added by Anaconda 1.9.1 installer
export PATH="${HOME}/anaconda/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ -f ~/.ssh/find-agent.sh ]; then
	. ~/.ssh/find-agent.sh
	if [ -z "$SSH_AUTH_SOCK" ]; then
		ssh_find_agent
	fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
