# Pathogen Vim Bundle Manager
## Motivation and description
This repository holds my vim configuration file, information on which modules/bundles I use and a script to manage and download these.
The main entry points to the setup are three files:
### vimrc
This file is the standard .vimrc file that contains basic editor configuration. Except for some shortcuts for tab-managements nothing fancy is in there.
Pathogen is the main entry point for all the bundles used in the settings, therefore, this vim-script is a must for this vimrc. It's not part of the repository though, but is automatically downloaded when initiaizing the view using **pvbm**.
### bundles
Here the information on which bundles are to be downloaded when to the view on initialization is located. Each line contains an identifier in square brackets [] and the url to the repository where it's stored in. For the url preferably github.com ssh-links may be used. The repositories are recuresively cloned into `bundle/` as submodules.
Example for NERDTree:
``` bash
[nerdtree] git@github.com:scrooloose/nerdtree.git
```
Naturally this file can be edited by hand, but there are several ways to do it with **pvbm**
### pvbm
**pvbm** (abbreviation for *p*athogen *v*im *b*undle *m*anager) is a bash-script wrapping initiaization and bundle managing functionality. Calling it without a flag does nothing. 
The script's help output:
``` bash
Usage: ./pvbm -[hicanr] <arg>
If no flag is given, nothing will be executed.
Flags:
  i       : Initialize the config view. Sets up pathogen and
            does an initial download of bundles defined in 
            file 'bundles'.
  c       : Clean up config view. Needs to be initialized again
            afterwards using -i.
  a <arg> : Add repository in <arg> to 'bundles' and downloads
            bundle data. Uses -n as optional, additional parameter.
  n <arg> : Optional. Only used in junction with -a <optarg>. Define 
            bundle name explicitly instead of deriving it from the 
            repository path.
  r <arg> : Remove the bundle in <arg> from 'bundles' and view.
  h       : Show this help.
```
Flags `a`, `n` and `r` are for adding and removing bundles. 
For adding, using flag `a` with the repository url is usually enough. An identifier will be derived from the repo-name. The caller is queried, whether the identifier is okay and can use a different, manually entered one, if necessary. With the optional `n` flag, the bundle-name can be explicitly specified when calling the script, as well.
No identifier shall be present twice, neither a repository url. If either is found in **bundles** on adding the a new bundle, nothing happens.
After a successful add, the repository is cloned into.
`r` does the opposite. It searches **bundles** for the identifier and if found, removes the line and the data in the bundle-directory.
### Makefile
The Makefile is a helper for creating the directory structure necessary for pathogen plus downloading pathogen itself, so not every init the script needs to be downloaded anew.
## Usage
Directly clone into this repo into your home directory, so a `.vim` directory is created.
``` bash
cd  ~
git clone git@github.com:mijoku/.vim.git
```
Initialization is done from within the view with **pvbm**.
``` bash
cd ~/.vim/
./pvbm -i
```
This last step initilaizes your view on first call, creating `autoload` and `bundle` directories, downloading `pathogen.vim` to autoload and cloning into all the repositories given in **bundles**.
After this vim should be set up and good to go.
## Dependencies
The scripts use these tools:
* make
* curl
* bash
  * sed
* git


