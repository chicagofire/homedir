#!/bin/bash
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

pushd ~
pushd $DIR
if [[ "$(git config --get 'submodule..vim/pack/github/opt/ale.active')" != "true" ]]; then
	git submodule init
	git submodule update
fi
popd

for item in .vim .bash_profile .bashrc .inputrc .tmux.conf .vimrc .asdf; do
	if [[ -e $item ]]; then
	    echo "$item exists in $HOME. moving to ${item}.bak"
	    mv $item ${item}.bak
	fi
	ln -s $DIR/$item $item
done

source ~/.bashrc

for plugin in bat direnv fd fzf jq ripgrep; do
    asdf plugin add $plugin
    asdf install $plugin latest
    asdf global $plugin latest
done

eval "$(direnv hook bash)"

# install micromamba
#  since we've sourced bashrc already, the OS/CPU ENV args are usable
export BIN_FOLDER=${HOME}/.local/${OS}-${CPU}/bin
export INIT_YES=n
export PREFIX_LOCATION=${HOME}/.local/${OS}-${CPU}/micromamba

tmpfile=$(mktemp /tmp/micromamba-installer.XXXXXX.sh)
curl -o $tmpfile -L micro.mamba.pm/install.sh
/bin/bash < $tmpfile
rm $tmpfile
