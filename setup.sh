#!/bin/bash

echo Initializing pathogen directory structure and scripts...
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#

echo Setting up requested submodules/bundles...
set -e
git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
  while read path_key path
  do
    url_key=$(echo $path_key | sed 's/\.path/.url/')
    url=$(git config -f .gitmodules --get "$url_key")
    git submodule add $url $path || true
  done

git submodule init && git submodule sync && git submodule update

echo Creating symbolic link...
if [[ -h ~/.vimrc ]] || [[ -f ~/.vimrc ]]; then
  echo ~/.vimrc already exists. Nothing linked.
else
  ln -s vimrc ~/.vimrc
fi

echo All done. VIM configured.
