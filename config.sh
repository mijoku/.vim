#!/bin/bash
MODFILE=bundles
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

# -a: mapping new bundle from given repository link.
if [[ -n $REPOSTRING ]]; then
  # check, whether given repository is already mapped.
  if [[ `grep $REPOSTRING -c $MODFILE` -gt 0 ]]; then
    MODLINE=`grep -m 1 $REPOSTRING $MODFILE`
    CURRMODNAME=`echo $MODLINE | sed -r "s/^\[(.*)\].*$/\1/"` 
    echo Given repository already mapped as bundle [$CURRMODNAME].
  else
    # -n: if the optional bundle name is not given, try to extract it
    #     from the repostring. the regex is geared to github repositories.
    if [[ -z $MODULENAME ]]; then
      echo Trying to extract bundle name from given repository string...
      MODULENAME=`echo $REPOSTRING | sed -r "s/^.*\/(.+)\.git$/\1/"`
      if [[ -n $MODULENAME ]]; then
        # some string could be extracted. check with user.
        read -r -p "Is [$MODULENAME] okay? [Y/n] " yn
        case $yn in
          ""|[yY]) echo [$MODULENAME] accepted.;;
          [nN]) read -r -p "Please enter the desired bundle name: " MODULENAME;;
          *)
            echo Invalid input.
            MODULENAME=""
            ;;
        esac
      else
        # no string could be extracted (wrong syntax).
        echo Bundle name could not be detected.
        read -r -p "Please enter the desired bundle name: " MODULENAME
      fi
    fi
    if [[ -z $MODULENAME ]]; then
      echo Empty bundle name not allowed. Nothing added.
    else
      if [[ `grep $MODULENAME -c $MODFILE` -gt 0 ]]; then
        echo Bundle name [$MODULENAME] already taken. Nothing added.
      else
        echo Adding [$MODULENAME] to $MODFILE...
        echo [$MODULENAME] $REPOSTRING >> $MODFILE
        git submodule add --force $REPOSTRING $BDIR/$MODULENAME
        update_git_submodules
      fi
    fi
  fi
fi

# -r: unmap the given bundle.
if [[ -n $REMNAME ]]; then
  if [[ `grep $REMNAME -c $MODFILE` -gt 0 ]]; then
    echo Removing bundle [$REMNAME]...
    sed -i "/^\[$REMNAME\].*$/d" $MODFILE
    rm -rf $BDIR/$REMNAME
  else
    echo [$REMNAME] not found. Nothing removed.
  fi
fi

# -c: clean config view (delete autoload/ and bundle/).
if [[ -n $DODEINIT ]]; then
  git submodule deinit --all
  make clean
fi

# -i: initialize config view (get pathogen, download all bundles).
if [[ -n $DOINIT ]]; then
  make init
  while read -r ln; do
    if [[ -n $ln ]]; then
      git submodule add --force `echo $ln | sed -r "s/^\[(.*)\][[:space:]]*(.*)$/\2\ $BDIR\/\1/"`
    fi
  done < $MODFILE
  update_git_submodules
fi

