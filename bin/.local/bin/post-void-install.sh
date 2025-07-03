#!/usr/bin/env bash

# Exit on error
set -e

for arg in "$@"; do    shift
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

if [ "$os" = "Linux" ]; then
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        distro_id=${ID,,}  # lowercase
        distro_name=${NAME}

        case "$distro_id" in
            void) 
                continue
                ;;
            *)
                echo "Void Linux not found." >&2
                exit 1
                ;;
        esac
    fi
fi


# Adding flathub repo
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Installing homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh

# Setting wifi
if [ ! -f "/var/service/dhcpcd" ]; then
    ln -s /etc/sv/dhcpcd/ /var/service
fi

if [ ! -f "/var/service/dhcpcd-eth0" ]; then
    ln -s /etc/sv/dhcpcd-eth0/ /var/service
fi

if [ ! -f "/var/service/wpa_supplicant" ]; then
    ln -s /etc/sv/wpa_supplicant/ /var/service
fi

read -rp "Config Wifi [y/N]: " wifi_choice
if [ -z "$wifi_choice" ] ; then
    echo "No choice selected. [Default choice - No]"
elif [ "$wifi_choice" = "N" ] || [ "$wifi_choice" = "n" ]; then
    echo "Not configuring WiFi"
elif [ "$wifi_choice" = "Y" ] || [ "$wifi_choice" = "y" ]; then
    echo "Network adapters:"
    wifi_list=$(ip link | awk -F ":" '/^[1-9]/ {print $2}' | grep -v lo | awk '{ print NR ": "  $0}')
    while true ;do
        echo "$wifi_list"
        echo "0: Stop configuring WiFi"
        read -rp "Select your wifi card: " wifi_card
        if [ -z "$wifi_card" ]; then
            echo "Select a choice"
            continue
        else
            break
        fi
    done
    echo "$wifi_list" | awk -v line="$wifi_card" 'NR == line {print $2}'               
else
    echo "Not configuring"
fi

# TODO: 
# 1. configure wifi with wpa_supplicant
# 2. make directories in user folder 
# 3. Install Niri - packages: 

# Update void packages
sudo xbps-install -Su

# Cloning the dotfiles git repo
sudo xbps-install git
git clone https://github.com/therealak7/dotfiles

# Adding void-src repository
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap

# Installing core packages
sudo xbps-install iwd

# Installing packages from base repository
sudo xbps-install figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git-lfs qbittorrent

# Building from void-src
./xbps-src pkg lolcat-c
sudo xbps-install --repository=hostdir/binpkgs lolcat-c
