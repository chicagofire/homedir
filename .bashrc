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

#
# Figure out which conda / mamba variant we're using preferring in order:
#   1. micromamba
#   2. mamba / miniforge3
#   3. miniconda3
#   4. conda
# They are all in ~/.local/<name>
#
if [[ -d ${HOME}/.local/bin/micromamba ]]; then
    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'micromamba shell init' !!
    export MAMBA_EXE="${HOME}/.local/bin/micromamba";
    export MAMBA_ROOT_PREFIX='${HOME}/.local/micromamba';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
       alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
    fi
    alias mamba=micromamba
    unset __mamba_setup
else
if [[ -d ${HOME}/.local/miniforge3 ]]; then
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
    export CONDA_EXE="${HOME}/.local/miniforge3/bin/conda"
	__conda_setup="$(${CONDA_EXE} 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "${HOME}/.local/miniforge3/etc/profile.d/conda.sh" ]; then
			. "${HOME}/.local/miniforge3/etc/profile.d/conda.sh"
		else
			export PATH="${HOME}/.local/miniforge3/bin:$PATH"
		fi
	fi
	unset __conda_setup

    if [ -f "${HOME}/.local/miniforge3/etc/profile.d/mamba.sh" ]; then
        . "${HOME}/.local/miniforge3/etc/profile.d/mamba.sh"
    else
        alias mamba=conda
    fi
else
if [[ -d ${HOME}/.local/miniconda3 ]]; then
    export CONDA_EXE="${HOME}/.local/miniconda3/condabin/conda"
    __conda_setup="$(${CONDA_EXE} 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${HOME}/.local/miniconda3/etc/profile.d/conda.sh" ]; then
            . "${HOME}/.local/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="${HOME}/.local/miniconda3/condabin:$PATH"
        fi
    fi
    unset __conda_setup
    alias mamba=conda
fi # miniconda3
fi # miniforge3 / mamba
fi # micromamba

# brew
if [[ -f /usr/local/Homebrew/completions/bash/brew ]]; then
    source /usr/local/Homebrew/completions/bash/brew
fi

# alacritty
if [[ "$TERM" = "alacritty" ]]; then
    export CLICOLOR=1
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ -f /usr/local/bin/kitty ]]; then
    eval "$(kitty + complete setup bash)"
fi

if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
    source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

eval "$(direnv hook bash)"
