#!/usr/bin/env bash
pkg_manager=$(sh ./get_pkg_manager.sh)


# Enabling extra repos

os=$(uname)

if [ "$os" = "Linux" ]; then

    # Detect distribution and package manager
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distro_id=${ID,,}  # lowercase
        if [ "$distro_id" = "fedora" ]; then
            sudo dnf copr enable atim/lazygit -y
            sudo dnf copr enable monkeygold/nautilus-open-any-terminal -y
            sudo dnf copr enable wezfurlong/wezterm-nightly -y
            sudo dnf copr enable alternateved/eza -y
            curl -fsSL https://repo.librewolf.net/librewolf.repo | pkexec tee /etc/yum.repos.d/librewolf.repo

            sudo dnf install dnf-plugins-core
            sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        fi
    fi
fi

# Installing with package manager

sudo $pkg_manager install -y figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git git-lfs brave librewolf wmctrl

# Installing flatpaks

flatpak install flathub app.zen_browser.zen com.github.tenderowl.frog com.valvesoftware.Steam dev.vencord.Vesktop eu.betterbird.Betterbird com.stremio.Stremio

# Install Mega - Online cloud storage service
wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install "$PWD/megasync-Fedora_42.x86_64.rpm"
