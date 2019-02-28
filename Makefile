# Things that will never be stowed
EXCLUDE:=termsupport/ xorg/
PACKAGES=$(filter-out $(EXCLUDE),$(sort $(dir $(wildcard */))))
.ONESHELL:

.DEFAULT_GOAL := help

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

dependencies: ## Installs a few packages on arch/debian/ubuntu
	@if [ -f /etc/arch-release ]; then
		pacman -Qi curl fd git ripgrep stow vim zsh >/dev/null || \
			sudo pacman -S --needed curl fd git ripgrep stow vim zsh
	elif [ -x "$$(command -v dpkg)" ]; then
		dpkg -s curl git-core ripgrep stow vim zsh &>/dev/null || \
			sudo apt install curl git-core ripgrep stow vim zsh
	else
		echo "Not running arch/debian based distro, skipping dependencies..."
	fi

install: ## Install dotfiles & dependencies
install: dependencies install-bin install-fontconfig install-git \
	install-ignore install-mpv install-pgsql install-ruby \
	install-terminal-settings install-tmux install-vim install-wm-settings \
	install-X install-zsh asdf
	@echo "Dotfiles installed!"

install-aur-helper: ## Install yay https://github.com/Jguer/yay
	@test -x /usr/bin/yay
	@if [[ $$? != 0 ]]; then
		@echo "Cloning yay..."
		git clone --quiet https://aur.archlinux.org/yay.git /tmp/yay
		@echo "Installing yay..."
		cd /tmp/yay && makepkg -si && cd -
		@echo "AUR Helper installation. Done."
	@fi

install-bin: ## Install bin folder
	@stow -Sv bin

install-fontconfig: ## Install font configuration
	@stow -Sv --no-folding fontconfig

install-git: ## Install git settings
	@stow -Sv git

install-ignore: ## Install ignore file used by rg and fd
	@stow -Sv ripgrep

install-mpv: ## Install mpv settings
	@stow -Sv mpv

install-pgsql: ## Install postgres settings
	@stow -Sv postgresql

install-ruby: ## Install ruby config files
	@stow -Sv ruby

install-terminal-settings: ## Install configs for terminal emulators
	@stow -Sv alacritty kitty tilix

install-tmux: ## Install tmux config
	@stow -Sv tmux

install-vim: ## Install vim settings/plugins
	@stow -Sv --no-folding nvim vim
	@if [ -e ~/.vim/autoload/plug.vim ]; then
		vim +PlugUpgrade +qa
	else
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	vim +PlugUpdate +PlugClean! +qa
	@echo "Vim plugins updated"

install-wm-settings: ## Install configs for i3, dunst etc on arch linux
	@if [ -f /etc/arch-release ]; then
		@stow -Sv --no-folding compton dunst gtk i3 i3lock polybar rofi X
	else
		echo "Not running Arch linux, skipping WM settings..."
	fi

install-X: ## Install Xresources
	@stow -Sv X

install-zsh: ## Install config for Z shell
	@stow -Sv zsh

asdf: ## Install asdf: https://github.com/asdf-vm/asdf
	@if [ -d ~/.asdf ]; then
		git -C ~/.asdf fetch --tags
		git -C ~/.asdf checkout `git -C ~/.asdf tag | sort -V | tail -1`
		~/.asdf/bin/asdf plugin-update --all
	else
		git clone https://github.com/asdf-vm/asdf.git ~/.asdf
		git -C ~/.asdf checkout `git -C ~/.asdf tag | sort -V | tail -1`
		~/.asdf/bin/asdf plugin-add ruby
		~/.asdf/bin/asdf plugin-add nodejs
		~/.asdf/bin/asdf plugin-add erlang
		~/.asdf/bin/asdf plugin-add elixir
	fi

arch-i3-desktop: install-aur-helper
	@pacman -Qi - < arch-i3-deps >/dev/null || \
		sudo pacman -S --needed - < arch-i3-deps
	@pacman -Qi - < aur-deps >/dev/null || \
		yay -S --needed - < aur-deps

clean:
	@stow -D $(PACKAGES)
	@echo "Unstowed packages"
	@rmdir --ignore-fail-on-non-empty ~/.config/gtk-3.0
	@rm -rf ~/.zsh
	@echo "Removed ~/.zsh directory"
	@rm -rf ~/.vim
	@echo "Removed ~/.vim directory"
	@rm -rf ~/.asdf
	@echo "Uninstalled asdf"
