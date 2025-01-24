umask 002

set -o vi

export ENV=$HOME/.bashrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PAGER="/usr/bin/less -R"
export EDITOR=vim
export SHELL=/bin/bash
export HISTFILE=~/.bash_history
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

# added by Anaconda 1.9.1 installer
export PATH="${HOME}/anaconda/bin:$PATH"

if ! command -v conda > /dev/null 2>&1; then
    export MINICONDA_HOME=${MINICONDA_HOME:-${HOME}/miniconda3}
    if [[ -f $MINICONDA_HOME ]]; then
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
    fi
    # <<< conda initialize <<<
fi
#
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/homebrew/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/jmayes/.local/share/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# brew
if [[ -f /usr/local/Homebrew/completions/bash/brew ]]; then
    source /usr/local/Homebrew/completions/bash/brew
fi

export PATH="/opt/homebrew/opt/icu4c@76/bin:$PATH"

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

source /opt/homebrew/opt/asdf/libexec/asdf.sh

eval "$(direnv hook bash)"
