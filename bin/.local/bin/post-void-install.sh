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
    echo "Network Interfaces:"
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
    selected_interface=$("$wifi_list" | awk -v line="$wifi_card" 'NR == line {print $2}')
else
    echo "Not configuring"
fi

while true; do
    read -rp "Enter WiFi SSID: " ssid
    read -rp "Enter WiFi password: " password
    if [ -z "$ssid" ] || [ -z "$password" ]; then
        echo "SSID or Password not entered"
        continue
    fi

    # Create a temporary wpa_supplicant config
    config="/tmp/test-wifi.conf"
    wpa_passphrase "$ssid" "$password" > "$config"

    # Kill any existing wpa_supplicant
    sudo pkill wpa_supplicant 2>/dev/null

    # Start wpa_supplicant in background with debug
    sudo wpa_supplicant -B -i "$selected_interface" -c "$config" -f /tmp/wpa.log
    sudo dhcpcd "$selected_wificard"

    # Wait up to 15 seconds for a successful connection
    for i in {1..15}; do
        if grep -q "CTRL-EVENT-CONNECTED" /tmp/wpa.log; then
            echo "Connected to '$ssid' successfully."
            sudo dhcpcd "$selected_interface" 2>/dev/null
            rm "$config"
            wpa_passphrase "$ssid" "$password" | sudo tee /etc/wpa_supplicant/wpa_supplicant.conf
            break
        fi
        sleep 1
    done

    echo "Failed to connect to '$ssid'."
    rm "$config"
done

# Adding flathub repo
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Installing homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh




# Update void packages
sudo xbps-install -Su

# Cloning the dotfiles git repo
sudo xbps-install git curl
git clone https://github.com/therealak7/dotfiles

# Adding void-src repository
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap

# Installing core packages
sudo xbps-install iwd mesa-dri elogind dbus polkit lightdm wayland wayland-utils xorg-fonts noto-fonts curl p7zip unzip

sudo xbps-install tree clang gcc

# TODO: 
# 1. configure wifi with wpa_supplicant
# 2. make directories in user folder 
# 3. Install Niri - packages: 
# 4. dbus elogind polkit lightdm mesa-dri wayland wayland-utils xorg-fonts noto-fonts
#       sudo ln -s  /etc/sv/[dbus/polkitd] /var/service
#       dbus-run-session niri --dbus-run-session
# Setting up greetd:
# 1. Req: greetd tuigreet elogind dbus niri
# 2. greeter user is needed to run greetd ('_greetd' in void linux)
#       sudo usermod -M -s /usr/bin/nologin _greetd (no user directorties are made for user and cannot login into it. THIS USER NEEDS TO BE ADDED TO VIDEO GROUP IF A GUI GREETER IS USED)
# 3. Configure /etc/greetd/config.toml
#       set vt as any aviablable tty that is not busy (vt=1)
#
#       [default-session]
#       command="greeter_name --cmd 'CMD(eg. sway, dbus-run-session niri)' --time --remember" #--tiem to show time --remeber to remember previous user
#       user="_greetd" #must be greeter user
# 4. check /etc/pam.d/greetd config
# 5. Enable greetd service 
#       sudo ln -s /etc/sv/greetd /var/service/
# 6. Disable agetty-tty1 service
#       sudo rm -rf /var/service/agetty-tty1/
# 7. Installing eww:
#       req: sudo xbps-install gtk+3-devel gtk-layer-shell-devel pango-devel gdk-pixbuf gdk-pixbuf-devel libdbusmenu-gtk3-devel cairo-devel glib-devel libgcc-devel glibc-devel gcc pkgconf
#   
#   Installing LibreWolf
#$ su
# echo 'repository=https://github.com/index-0/librewolf-void/releases/latest/download/' > /etc/xbps.d/20-librewolf.conf
# xbps-install -Su librewolf

# Downloading Niri packages
sudo xbps-install niri fuzzel mako xdg-desktop-portal-gtk alacritty swaybg swayidle swaylock xdg-desktop-portal-gnome xwayland-satellite Waybar

# Installing packages from base repository
sudo xbps-install figlet nvim ripgrep fd-find python3-pip eza lolcat lazygit wezterm fastfetch fzf stow fish git-lfs qbittorrent

# Building from void-src
./xbps-src pkg lolcat-c
sudo xbps-install --repository=hostdir/binpkgs lolcat-c
