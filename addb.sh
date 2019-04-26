#!/bin/bash

if [[ -z $1 || -z $2 ]]; then 
  echo Vim-module name and repository need to be provided with this script. Exiting. 
  exit 1
fi
echo Trying to set up \"$1\" from "$2" ...
git submodule add $2 bundle/$1 && git submodule update --init --recursive && git reset bundle/*
if [[ $? -ne 0 ]]; then
  echo Adding $1 failed. Check the ouptut and names/paths given.
  exit 2
else
  echo Setting up bundle $1 done.
fi
