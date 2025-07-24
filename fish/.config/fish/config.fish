if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable original fish greeting
set -U fish_greeting

# Custom greeting
# sh $HOME/.local/bin/greetings_stardrop.sh
figlet -c -f "$HOME/dotfiles/assets/fonts/SmSlant.flf" "zexy" | lolcat

##### Environment Variables #####
export CONFIG_DIR="$HOME/.config"
export fish_conf="$CONFIG_DIR/fish/config.fish"



starship init fish | source

##### ALIASES #####
alias lsl='ls -lAgoh --color=auto --group-directories-first --time-style=locale'
alias cls='clear'
alias dots='cd ~/dotfiles'

alias pdftk='java -jar $HOME/.local/bin/pdftk-all.jar'

alias nv='nvim'
alias nl='NVIM_APPNAME="nvim-lazyvim" nvim'
alias nk='NVIM_APPNAME="nvim-kickstart" nvim'


# Configuration aliases
# Fish Config
alias nfishrc="nvim $CONFIG_DIR/fish/config.fish"
alias sfishrc="source $CONFIG_DIR/fish/config.fish"
# Wezterm Config
alias nwezrc="nvim $WEZTERM_CONFIG_FILE"
alias swezrc="source $WEZTERM_CONFIG_FILE"
# Straship config
alias nshiprc="nvim $CONFIG_DIR/starship.toml"
# kitty Config
alias nkittyrc="nvim $CONFIG_DIR/kitty/kitty.conf"
alias skittyrc="source $CONFIG_DIR/kitty/kitty.conf"
alias lg="lazygit"
alias greets="sh $HOME/.local/bin/greetings_stardrop.sh"


### ABBREVIATIONS ###

abbr .. 'cd ..'
abbr xi 'xbps-install'
abbr sxi 'sudo xbps-install'
abbr sxr 'sudo xbps-remove'

### VOID LINUX ALIASES AND FUNCTIONS ###

# Functions
function xsrc-install -d "Build and install packages from void-src"
    command $HOME/void-packages/xbps-src pkg $argv
    if test $status = 0
        sudo xbps-install --repository=hostdir/binpkgs $argv
    end
end

function xsrc-query -d "Search for packgakes in void-src using ls"
    ls $HOME/void-packages/srcpkgs | grep $1
end

function mkcd -d "Create a directory and cd into it"
    if test (count $argv) -eq 0
        echo "Usage: mkcd <directory>"
        return 1
    end

    mkdir -p -- $argv
    if test $status -eq 0
        cd -- $argv[-1]
    end
end
