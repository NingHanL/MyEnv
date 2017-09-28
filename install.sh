#!/usr/bin/env bash

APT_PACKAGES="vim git-core zsh tig ctags"

install_apt_packages() {
  for pkg in $APT_PACKAGES; do
      sudo apt install $pkg
  done
}
install_apt_packages

setup_vim(){
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ln -sf ./vimrc ~/.vimrc
  vim +PluginInstall +qall
}
setup_vim

setup_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # optional
  sudo -u $USER chsh -s /bin/zsh
}
setup_zsh

add_bin_to_system_path() {
  echo $PATH | grep -q "$(realpath .)/bin" || {
    cmd="export PATH=$PATH:$(realpath .)/bin"
    echo -e "\n$cmd" >> ~/.bashrc
    echo -e "\n$cmd" >> ~/.zshrc
  }
}
add_bin_to_system_path

setup_sh_configs() {
  cmd="export $(realpath .)/shell_config"
  echo -e "\n$cmd" >> ~/.bashrc
  echo -e "\n$cmd" >> ~/.zshrc
}
setup_sh_configs
