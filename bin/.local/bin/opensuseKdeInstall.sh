#!/usr/bin/env bash


sudo zypper refresh
sudo zypper update

# Adding repositories
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


# Installing apps from package manager
sudo zypper install -y figlet nvim ripgrep fd-find python3-pip eza lazygit wezterm fastfetch fzf stow fish git git-lfs

# Installing codes
sudo zypper install opi
opi codes

# Installing apps from flatpaks
flatpak install flathub com.github.tenderowl.frog com.valvesoftware.Steam dev.vencord.Vesktop eu.betterbird.Betterbird com.brave.Browser io.gitlab.librewolf-community 

# Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installing apps from brew
brew install lolcat
