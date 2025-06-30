if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable original fish greeting
set -U fish_greeting

# Custom greeting
sh $HOME/.local/bin/greetings_stardrop.sh

##### Environment Variables #####
export CONFIG_DIR="$HOME/.config"
export fish_conf="$CONFIG_DIR/fish/config.fish"



starship init fish | source

##### ALIASES #####
alias lsl='ls -lAgoh --color=auto --group-directories-first --time-style=locale'
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
alias lg="lazygit"
