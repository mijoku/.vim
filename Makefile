#/bin/make

# TODO: check for dependencies prior to execution.
# dependencies up until now:
# 	curl
# 	git
# 	sed

ALDIR := autoload
BDIR ?= bundle

pathogen: $(ALDIR)/pathogen.vim
$(ALDIR)/pathogen.vim: | $(ALDIR) $(BDIR)
	@echo **Downloading pathogen...
	@curl -LSso $@ https://tpo.pe/pathogen.vim
$(ALDIR) $(BDIR):
	@echo Creating directory structure...
	@mkdir -p $@

conffile: ~/.vimrc
~/.vimrc: vimrc
	@echo Setting up symlink to vimrc...
	@ln -sf $^ $@

init: pathogen conffile

all: init

clean:
	@echo Cleaning view...
	@rm -rf $(ALDIR)
	@rm -rf $(BDIR)
	@rm -f .gitmodules
	@rm -f ~/.vimrc

.PHONY: init pathogen conffile all clean

