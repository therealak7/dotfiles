#!/bin/bash

# Exit on error
set -e

# Determine OS name
os=$(uname)

if [ "$os" = "Linux" ]; then
    # echo "This is a Linux Machine"

    # Initialize package manager
    pkg_manager=""
    distro_id=""
    distro_name=""

    # Detect distribution and package manager
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distro_id=${ID,,}  # lowercase
        distro_name=${NAME}

        case "$distro_id" in
            ubuntu|debian)
                pkg_manager="apt"
                ;;
            rhel|centos|rocky|almalinux)
                pkg_manager="yum"
                ;;
            fedora)
                pkg_manager="dnf"
                ;;
            arch)
                pkg_manager="pacman"
                ;;
            alpine)
                pkg_manager="apk"
                ;;
            suse|opensuse*)
                pkg_manager="zypper"
                ;;
            *)
                ;;
        esac
    fi

    # Fallback detection if os-release missing
    if [[ -z "$pkg_manager" ]]; then
        if command -v apt >/dev/null; then
            pkg_manager="apt"
        elif command -v yum >/dev/null; then
            pkg_manager="yum"
        elif command -v dnf >/dev/null; then
            pkg_manager="dnf"
        elif command -v pacman >/dev/null; then
            pkg_manager="pacman"
        elif command -v apk >/dev/null; then
            pkg_manager="apk"
        elif command -v zypper >/dev/null; then
            pkg_manager="zypper"
        fi
    fi

    # Show result
    if [[ ! -n "$pkg_manager" ]]; then
        echo "Could not detect package manager."
        exit 1
    fi

else
    echo "Unsupported OS: $os"
    exit 1
fi


# Adding repositories
if [[ "$distro_id" == "fedora" || "$pkg_manager" == "dnf" ]]; then
    echo "here fedora"
elif [[ "$distro_id" == opensuse* || "$distro_id" == "suse" || "$pkg_manager" == "zypper" ]]; then
    echo "opensuse"
else
    echo "Repositories not set for this distro"
    echo "$distro_id"
    echo "$distro_name"
fi

# Installing with package manager
# sudo $pkg_manager install -y figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git git-lfs brave librewolf wmctrl
#
# # Installing flatpaks
# flatpak install flathub app.zen_browser.zen com.github.tenderowl.frog com.valvesoftware.Steam dev.vencord.Vesktop eu.betterbird.Betterbird com.stremio.Stremio
#
# # Install Mega - Online cloud storage service
# wget https://mega.nz/linux/repo/Fedora_42/x86_64/megasync-Fedora_42.x86_64.rpm && sudo dnf install "$PWD/megasync-Fedora_42.x86_64.rpm"
