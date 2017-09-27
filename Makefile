# List of folders that won't be stowed
EXCLUDE=termsupport/ bin/
PACKAGES=$(filter-out $(EXCLUDE),$(sort $(dir $(wildcard */))))
ASDF_DIR=~/.asdf

default: install

# Installs stow using whatever package manager is available
dependencies:
	@command -v stow >/dev/null 2>&1 || \
		brew install stow 2>/dev/null || \
		sudo apt install -y stow 2>/dev/null || \
		sudo pacman -S --noconfirm stow >/dev/null || \
		{ echo >&2 "Please install GNU stow"; exit 1; }

# Places symlinks in ~/
# Creates ~/.vim and ~/.config folders to avoid new files being added
# to the dotfiles repo unintentionally
symlink:
	@mkdir -p ~/.vim
	@mkdir -p ~/.config
	@stow $(PACKAGES)

link_bin:
	@ln -sfnv `pwd`/bin ~/bin

# Installs vim plugins via vim-plug. Downloads vim-plug if unavailable.
vim_plugins:
	@test -s ~/.vim/autoload/plug.vim || \
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +PlugClean! +qa
	@echo "Vim plugins installed..."

# Set up asdf version manager
# https://github.com/asdf-vm/asdf
asdf: | $(ASDF_DIR)

$(ASDF_DIR):
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	@git -C ~/.asdf checkout `git -C ~/.asdf tag | sort -V | tail -1`
	@~/.asdf/bin/asdf plugin-add ruby
	@~/.asdf/bin/asdf plugin-add nodejs

install: dependencies symlink link_bin vim_plugins asdf
	@echo "Dotfiles installed!"
