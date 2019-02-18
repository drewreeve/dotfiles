# Things that will never be stowed
EXCLUDE:=termsupport/ xorg/
PACKAGES=$(filter-out $(EXCLUDE),$(sort $(dir $(wildcard */))))
ASDF_DIR=~/.asdf

.DEFAULT_GOAL := help

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: stow asdf ## Stow everything and setup asdf
	@echo "Dotfiles installed!"

stow: install_stow ## Stow everything
	@stow --no-folding $(PACKAGES)
	@echo "All packages stowed"

# Installs stow using whatever package manager is available
install_stow:
	@command -v stow >/dev/null 2>&1 || \
		brew install stow 2>/dev/null || \
		sudo apt install -y stow 2>/dev/null || \
		sudo pacman -S --noconfirm stow >/dev/null || \
		{ echo >&2 "Please install GNU stow"; exit 1; }

asdf: | $(ASDF_DIR) ## Install asdf: https://github.com/asdf-vm/asdf

$(ASDF_DIR):
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	@git -C ~/.asdf checkout `git -C ~/.asdf tag | sort -V | tail -1`
	@~/.asdf/bin/asdf plugin-add ruby
	@~/.asdf/bin/asdf plugin-add nodejs
	@~/.asdf/bin/asdf plugin-add erlang
	@~/.asdf/bin/asdf plugin-add elixir

clean: ## Unstow packages and removes asdf and vim directories
	@stow -D $(PACKAGES)
	@echo "Unstowed packages"
	@rmdir --ignore-fail-on-non-empty ~/.config/gtk-3.0
	@rm -rf ~/.vim
	@echo "Removed ~/.vim directory"
	@rm -rf ~/.asdf
	@echo "Uninstalled asdf"
