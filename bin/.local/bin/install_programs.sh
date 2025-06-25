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
            sudo $pkg_manager copr enable atim/lazygit -y
            sudo $pkg_manager copr enable monkeygold/nautilus-open-any-terminal -y
            sudo $pkg_manager copr enable wezfurlong/wezterm-nightly -y
            sudo $pkg_manager copr enable alternateved/eza -y
        fi
    fi
fi

# Installing with package manager

sudo $pkg_manager install -y figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish

# Installing flatpaks

flatpak install flathub app.zen_browser.zen com.github.tenderowl.frog com.valvesoftware.Steam dev.vencord.Vesktop
