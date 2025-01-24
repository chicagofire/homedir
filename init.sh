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

for item in .ssh .vim .bash_profile .bashrc .inputrc .tmux.conf .vimrc; do
	if [[ -e $item ]]; then
	    echo "$item exists in $HOME. moving to ${item}.bak"
	    mv $item ${item}.bak
	fi
	ln -s $DIR/$item $item
done
