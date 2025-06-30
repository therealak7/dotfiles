#!/usr/bin/env bash

# Exit on error
set -e

for arg in "$@"; do
    shift
    case "$arg" in
        "--root") override_root=1 ;;
        *)
        if echo "$arg" | grep -qv "^-"; then
            tag="$arg"
        else
            echo "Invalid option $arg" >&2
            exit 1
        fi
    esac
done

is_root() {
    [ "$(id -u)" -ne 0 ]
}

if ! is_root && [ "${override_root:-0}" -eq 0 ]; then
    echo "The script was ran under sudo or as root. The script will now exit"
    echo "If you hadn't intended to do this, please execute the script without root access to avoid problems with spicetify"
    echo "To override this behavior, pass the '--root' parameter to this script"
    exit
fi


# Determine OS name
os=$(uname)

if [ "$os" = "Linux" ]; then

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

# Installing Homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh

case "$distro_id" in
    ubuntu|debian)
        echo "Repositories not set"
        ;;
    rhel|centos|rocky|almalinux)
        echo "Repositories not set"
        ;;
    fedora)
        # Adding repositories
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        sudo dnf copr enable atim/lazygit -y
        sudo dnf copr enable wezfurlong/wezterm-nightly -y
        sudo dnf copr enable alternateved/eza -y
        # TODO: shift this repository to gnome section
        # sudo dnf copr enable monkeygold/nautilus-open-any-terminal -y # Gnome only
        ;;
    arch)
        echo "Repositories not set"
        ;;
    alpine)
        echo "Repositories not set"
        ;;
    suse|opensuse*)
        # Adding repositories
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        sudo zypper ar https://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Factory/devel:languages:go.repo # repo for lazygit
        brew install lolcat
        ;;
    *)
        ;;
esac


# Installing with package manager
sudo $pkg_manager install -y figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git git-lfs qbittorrent

# Installing flatpaks
flatpak install flathub com.github.tenderowl.frog com.valvesoftware.Steam dev.vencord.Vesktop eu.betterbird.Betterbird com.stremio.Stremio io.gitlab.librewolf-community com.brave.Browser
