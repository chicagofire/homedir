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
export OS=$(uname -s | tr "[:upper:]" "[:lower:]")
export CPU=$(uname -m)

alias ls="ls --color=auto"
alias gitwt="git worktree"
function gitp()
{
    if [[ "$1" == "ush" ]]; then
        git push "${@:2}"
    fi
}

function count_by
{
    local field key line opt delim="\t"
    declare -A counts
    while getopts ":d:f" opt; do
        case $opt in
            d)
                delim="${OPTARG}"
                ;;
            f)
                field="${OPTARG}"
                ;;
            *)
                echo "Unknown option: $opt"
                return -1
                ;;
        esac
    done

    while IFS= read -r line; do
        key=$(echo "$line" | cut -d "${delim}" -f "${field}")
        (( counts["$key"]++ ))
    done

    for key in "${!counts[@]}"; do
        echo "$key: ${counts[$key]}"
    done
}

# brew
# if [[ -f /usr/local/Homebrew/completions/bash/brew ]]; then
#     source /usr/local/Homebrew/completions/bash/brew
# fi

# alacritty
if [[ "$TERM" = "alacritty" ]]; then
    export CLICOLOR=1
fi

if [[ -f /usr/local/bin/kitty ]]; then
    eval "$(kitty + complete setup bash)"
fi

function remove_path()
{
    for subpath in $(echo ${PATH} | tr ":" "\n"); do
        if [[ "$subpath" == *$1* ]]; then
            PATH=${PATH/$subpath/}
        fi
    done
    PATH=${PATH//::/:}
}

# put host / env / job specific stuff in bashrc.local
# including any pixi stuff
if [[ -f "${HOME}/.bashrc.local" ]]; then
    source "${HOME}/.bashrc.local"
fi

# the global tool config happens after local so that we can set up pixi, mamba, asdf, homebrew, etc
export FZF_DEFAULT_COMMAND="fd -u -t f --exclude .pixi --exclude .git --exclude .venv --strip-cwd-prefix"
eval "$(fzf --bash)"

# put this at the very end
eval "$(starship init bash)"

if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion

    # sometimes the loader doesn't work, so, just force the completion to load
    _completion_loader git
fi

export MISE_ENV_FILE=.env
export FNOX_AGE_KEY_FILE=~/.ssh/id_ed25519
eval "$(mise activate bash)"
eval "$(fnox activate bash)"
