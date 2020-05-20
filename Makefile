DOTFILES=.vim .vimrc .gvimrc .ideavimrc .zsh .zshenv .zshrc .bashrc .tmux.conf .gitconfig
DOTFILES_REPO := $(shell ghq root)/github.com/alpicola/dotfiles

.PHONY: install
install: $(DOTFILES_REPO)
	@$(foreach f, $(DOTFILES), ln -sfnv $(DOTFILES_REPO)/$(f) $(HOME)/$(f);)

$(DOTFILES_REPO):
	ghq get alpicola/dotfiles
