#!/bin/bash

# Determine OS name
os=$(uname)

if [ "$os" = "Linux" ]; then
    # echo "This is a Linux Machine"

    # Initialize package manager
    pkg_manager=""

    # Detect distribution and package manager
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distro_id=${ID,,}  # lowercase
        distro_name=${NAME}

        echo "Detected Linux distro: $distro_name"

        case "$distro_id" in
            ubuntu|debian)
                pkg_manager="apt"
                ;;
            rhel|centos|fedora|rocky|almalinux)
                pkg_manager="yum"
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
                echo "Unknown Linux distro ($distro_id), attempting fallback..."
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
    if [[ -n "$pkg_manager" ]]; then
        echo "Detected package manager: $pkg_manager"
        sudo "$pkg_manager" install "$1" 
    else
        echo "Could not detect package manager."
        exit 1
    fi

elif [ "$os" = "Darwin" ]; then
    if command -v brew >/dev/null; then
        pkg_manager="brew"
        echo "Detected package manager: brew"
        brew install "$1"
    else
        echo "Homebrew not found. Please install it: https://brew.sh"
        exit 1
    fi

else
    echo "Unsupported OS: $os"
    exit 1
fi

echo "$1 has been installed"

