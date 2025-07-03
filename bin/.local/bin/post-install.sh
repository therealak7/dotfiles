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


os=$(uname)

pkg_manager=""
distro_id=""
distro_name=""

if [ "$os" = "Linux" ]; then


    # Detect distribution and package manager
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distro_id=${ID,,}  # lowercase
        distro_name=${NAME}

        case "$distro_id" in
            fedora) 
                pkg_manager="dnf install"
                ;;
            void) 
                pkg_manager="xbps-install"
                ;;
            suse|opensuse*) 
                pkg_manager="zypper install"
                ;;
            *)
                echo "Could not determine" >&2
                exit 1
                ;;
        esac
    fi
fi

pkg_mngr_name=$(echo "$pkg_manager" | awk -F'[ -]' '{print $1}')
echo "Detected Linux distribution: $distro_name"
echo "Preferred package manager: $pkg_mngr_name"
read -rp "Confirm[Y/n]: " distro_choice

if [ -z "$distro_choice" ]; then
    distro_choice="Y"
fi

case "$distro_choice" in
    "Y"|"y")
        continue
        ;;
    "N"|"n")
        while true; do
            echo ""
            echo "---DISTRIBUTIONS---"
            echo "1: Fedora | dnf"
            echo "2: openSUSE | zypper"
            echo "3: Void Linux | xbps"
            echo "4: Exit"
            echo ""
            read -rp "Enter your distribution: " distro
            echo ""
            if [ -z "$distro" ]; then
                echo "No such choice."
                continue
            elif [ "$distro" -eq 4 ]; then
                echo "Exited script" >&2
                exit 1
            fi
            case "$distro" in
                1)
                    distro_id="fedora"
                    pkg_manager="dnf install"
                    ;;
                2)
                    distro_id="suse"
                    pkg_manager="zypper install"
                    ;;
                3)
                    distro_id="void"
                    pkg_manager="xbps-install"
                    ;;
                *)
                    echo "No such choice"
                    continue
                    ;;
            esac
            break
        done
        ;;
    *)
        echo "No such choice" >&2
        exit 1
        ;;
esac

# Adding flathub repo
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Installing homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh

case "$distro_id" in
    fedora)
        # Updating the packages
        sudo dnf upgrade --refresh

        # Cloning the dotfiles git repo
        sudo dnf install git
        git clone https://github.com/therealak7/dotfiles

        # Adding repositories
        sudo dnf copr enable atim/lazygit -y
        sudo dnf copr enable wezfurlong/wezterm-nightly -y
        sudo dnf copr enable alternateved/eza -y
        ;;
    suse|opensuse*)
        ;;
    void)
        # Updating the packages
        sudo xbps-install -Su

        # Cloning the dotfiles git repo
        sudo xbps-install git
        git clone https://github.com/therealak7/dotfiles

        # Adding void-src repository
        git clone https://github.com/void-linux/void-packages
        cd void-packages
        ./xbps-src binary-bootstrap

        ./xbps-src pkg lolcat-c
        sudo xbps-install --repository=hostdir/binpkgs lolcat-c
        ;;
    *)
        echo "Could not get correct distro ID" >&2
        ;;
esac


sudo $pkg_manager figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git-lfs qbittorrent



# pkg_manager=""
#
# case "$distro" in
#     1) pkg_manager="dnf install"
#         ;;
#     2) pkg_manager="zypper install"
    #         ;;
#     3) pkg_manager="xbps-install"
    #         ;;
#     *) echo default
    #         ;;
    # esac
    #
    # pkg_mngr_name=$(echo "$pkg_manager" | awk -F'[ -]' '{print $1}')
    # echo "Preferred package manager: $pkg_mngr_name"
    # echo ""
    #
    # echo "Desktop Environment/Window Manager"
    # echo "1: GNOME"
    # echo "2: KDE Plasma"
    # echo "3: Niri"
    # echo ""
    # read -rp "Enter your choice: " dm
    #
    #
