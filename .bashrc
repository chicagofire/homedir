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

# added by Anaconda 1.9.1 installer
export PATH="${HOME}/anaconda/bin:$PATH"
export OS=$(uname -s | tr "[:upper:]" "[:lower:]")
export CPU=$(uname -m)

#
# Figure out which conda / mamba variant we're using preferring in order:
#   1. micromamba
#   2. mamba / miniforge3
#   3. miniconda3
#   4. conda -tbd
# They are all in ~/.local/<name>
#
if [[ -f ${HOME}/.local/${OS}-${CPU}/bin/micromamba ]]; then
    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'micromamba shell init' !!
    export MAMBA_EXE="${HOME}/.local/${OS}-${CPU}/bin/micromamba";
elif [[ -f /opt/homebrew/bin/micromamba ]]; then
    export MAMBA_EXE="/opt/homebrew/bin/micromamba"
elif [[ -d ${HOME}/.local/${OS}-${CPU}/miniforge3 ]]; then
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
    export _CONDA_ROOT_PREFIX="${HOME}/.local/${OS}-${CPU}/miniforge3"
elif [[ -d ${HOME}/.local/${OS}-${CPU}/miniconda3 ]]; then
    export _CONDA_ROOT_PREFIX="${HOME}/.local/${OS}-${CPU}/miniconda3"
fi

if [[ "${MAMBA_EXE}" != "" ]]; then
    export MAMBA_ROOT_PREFIX="${HOME}/.local/${OS}-${CPU}/micromamba";
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
       alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
    fi
    alias mamba=micromamba
    unset __mamba_setup
elif [[ "${_CONDA_ROOT_PREFIX}" != "" ]]; then
    export CONDA_EXE="${_CONDA_ROOT_PREFIX}/bin/conda"
	__conda_setup="$(${CONDA_EXE} 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "${_CONDA_ROOT_PREFIX}/etc/profile.d/conda.sh" ]; then
			. "${_CONDA_ROOT_PREFIX}/etc/profile.d/conda.sh"
		else
			export PATH="${_CONDA_ROOT_PREFIX}/bin:$PATH"
		fi
	fi

    if [[ -f "${_CONDA_ROOT_PREFIX}/etc/profile.d/mamba.sh" ]]; then
        . "${_CONDA_ROOT_PREFIX}/etc/profile.d/mamba.sh"
    else
        alias mamba=conda
    fi
	unset __conda_setup
    unset _CONDA_ROOT_PREFIX
fi

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

export ASDF_DATA_DIR=$HOME/.local/${OS}-${CPU}/asdf
if [[ -f $HOME/.asdf/asdf.sh ]]; then
    . $HOME/.asdf/asdf.sh
fi

if [[ -f $HOME/.asdf/completions/asdf.bash ]]; then
    . $HOME/.asdf/completions/asdf.bash
fi

if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
    source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

BASE_PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "

show_virtual_env() {
    if [[ "${CONDA_DEFAULT_ENV}" != "" ]]; then
        if [[ "$(dirname ${CONDA_DEFAULT_ENV})" = ${PWD} ]]; then
            export PS1="($(basename ${CONDA_DEFAULT_ENV})) ${BASE_PS1}"
        else
            export PS1="(${CONDA_DEFAULT_ENV}) ${BASE_PS1}"
        fi
    else
        export PS1="${BASE_PS1}"
    fi
    set +x
}
export PROMPT_COMMAND=show_virtual_env

eval "$(direnv hook bash)"
