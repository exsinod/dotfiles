sudo su
pacman -Syuu
pacman -S neovim ripgrep alacritty exa tmux

# Not for GNOME
#yay -S spotify nvim-packer-git google-chrome nerd-fonts-fantasque-sans-mono

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# install node, npm
nvm install stable
npm install -g neovim

# install Packer (nvim)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Nvim install packages
sh -c "nvim +'PackerInstall'"

# Install SdkMan
zsh <(curl -s "https://get.sdkman.io")

# Initialize dotfiles HOME
mkdir .cfg
git clone --bare https://github.com/exsinod/dotfiles.git $HOME/.cfg
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add *
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME stash
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout manjaro

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
