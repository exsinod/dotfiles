#!/bin/bash

set -x
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

if [[ ! -d $XDG_CACHE_HOME/first-install ]]
then
sudo dnf install git zsh neovim python3-pip docker fd-find ripgrep the_silver_searcher fzf

cd $HOME
git clone https://github.com/exsinod/dotfiles.git && cd dotfiles && git checkout nobara
cp -r .config/* $HOME/.config/
cp .zshrc $HOME/ && source $HOME/.zshrc
cd $HOME

# install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

# install node, npm
nvm install lts/gallium

# configure tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# configure vim
npm install --global yarn neovim tree-sitter
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sh -c "nvim +'PlugInstall --sync' +qa"
sh -c "nvim +':CocInstall coc-tsserver coc-java coc-python' +qa"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install SdkMan
zsh <(curl -s "https://get.sdkman.io")

cd $HOME
find dotfiles -type f ! -path "dotfiles" ! -path "*.git*" ! -path "*README.md" | sed 's,dotfiles,~,g' | xargs -I{} sh -c "rm -rf {}"
rm -rf dotfiles

# Initialize dotfiles HOME
mkdir .cfg
git clone --bare https://github.com/exsinod/dotfiles.git $HOME/.cfg
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add *
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME stash
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout nobara

echo "\n\n\nAdd your ssh key to github and run this script again."
mkdir -p $XDG_CACHE_HOME/first-install
fi