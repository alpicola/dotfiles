DOTFILES=.vim .vimrc .gvimrc .zsh .zshenv .zshrc .tmux.conf .gitconfig
DOTFILES_REPO := $(shell ghq list -p alpicola/dotfiles)

.PHONY: install
install: $(DOTFILES_REPO)
	@$(foreach f, $(DOTFILES), ln -sfnv $(DOTFILES_REPO)/$(f) $(HOME)/$(f);)

$(DOTFILES_REPO):
	ghq get alpicola/dotfiles
	cd $(DOTFILES_REPO); git submodule update --init