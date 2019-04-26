#!/bin/bash
MODFILE=modules
BDIR=bundle

while getopts "ica:n:r:" arg; do
  case $arg in 
    i) DOINIT=true;;
    c) DODEINIT=true;;
    a) REPOSTRING=$OPTARG;;
    n) MODULENAME=$OPTARG;;
    r) REMNAME=$OPTARG;;
  esac
done

if [[ -n $REPOSTRING ]]; then
  # TODO Add another bundle to module file.
  echo nothing... 
fi

if [[ -n $REMNAME ]]; then
  
  sed "/^\[$REMNAME\].*$/d" $MODFILE
fi

if [[ -n $DODEINIT ]]; then
  git submodule deinit --all
  make clean
fi

if [[ -n $DOINIT ]]; then
  make init
  while read -r ln; do
    if [[ -n $ln ]]; then
      git submodule add --force `echo $ln | sed -r "s/^\[(.*)\][[:space:]]*(.*)$/\2\ $BDIR\/\1/"`
    fi
  done < $MODFILE
  git submodule update --init --recursive 
  git reset .gitmodules
  git reset bundle/*
fi

