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

update_git_submodules () {
  git submodule update --init --recursive 
  git reset -q .gitmodules
  git reset -q $BDIR/*
}

if [[ -n $REPOSTRING && -n $MODULENAME ]]; then
  if [[ `grep $REPOSTRING -c $MODFILE` -gt 0 ]]; then
    echo Given repository string already exists.
  else
    if [[ `grep $MODULENAME -c $MODFILE` -gt 0 ]]; then
      echo Given bundle name already taken.
    else
      echo [$MODULENAME] $REPOSTRING >> $MODFILE
      git submodule add --force $REPOSTRING $BDIR/$MODULENAME
      update_git_submodules
    fi
  fi
fi

if [[ -n $REMNAME ]]; then
  if [[ `grep $REMNAME -c $MODFILE` -gt 0 ]]; then
    echo Removing bundle $REMNAME...
    sed -i "/^\[$REMNAME\].*$/d" $MODFILE
    rm -rf $BDIR/$REMNAME
  else
    echo $REMNAME not found. Nothing removed.
  fi
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
  update_git_submodules
fi

