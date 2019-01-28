# Things that will never be stowed
EXCLUDE:=termsupport/ xorg/
PACKAGES=$(filter-out $(EXCLUDE),$(sort $(dir $(wildcard */))))
ASDF_DIR=~/.asdf

.DEFAULT_GOAL := help

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: stow asdf vim_plugins ## Stow everything and setup asdf and vim
	@echo "Dotfiles installed!"

stow: install_stow makedirs ## Stow everything
	@stow $(PACKAGES)
	@echo "All packages stowed"

# Make these directories to avoid new files in them being added to the git repo
makedirs:
	@mkdir -p ~/.vim
	@mkdir -p ~/.config/gtk-3.0

# Installs stow using whatever package manager is available
install_stow:
	@command -v stow >/dev/null 2>&1 || \
		brew install stow 2>/dev/null || \
		sudo apt install -y stow 2>/dev/null || \
		sudo pacman -S --noconfirm stow >/dev/null || \
		{ echo >&2 "Please install GNU stow"; exit 1; }

vim_plugins: ## Downloads vim-plug and installs plugins
	@test -s ~/.vim/autoload/plug.vim || \
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +PlugClean! +qa
	@echo "Vim plugins installed..."

asdf: | $(ASDF_DIR) ## Install asdf: https://github.com/asdf-vm/asdf

$(ASDF_DIR):
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	@git -C ~/.asdf checkout `git -C ~/.asdf tag | sort -V | tail -1`
	@~/.asdf/bin/asdf plugin-add ruby
	@~/.asdf/bin/asdf plugin-add nodejs
	@~/.asdf/bin/asdf plugin-add erlang
	@~/.asdf/bin/asdf plugin-add elixir
