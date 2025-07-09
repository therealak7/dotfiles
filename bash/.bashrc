# .bashrc

# If not running interactively do not do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

### ENVIRONMENT VARIABLES ###
export CONFIG_DIR="$HOME/.config"
export fish_conf="$CONFIG_DIR/fish/config.fish"


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(starship init bash)"

### FUNCTIONS ###

# Make directory if not existing while copying
mkcp() { mkdir -p `dirname $2` && cp "$1" -r "$2"; }

### ALIAS ###
alias lsl='ls -lAgoh --color=auto --group-directories-first --time-style=locale'
alias mkdir='mkdir -p'
alias dots='cd ~/dotfiles'

# If fish shell exists, it is started as the interactive shell in the terminal
if [[ -f /usr/bin/fish && $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi

PS1='[\u@\h \W]\$ '
