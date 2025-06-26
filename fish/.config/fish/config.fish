if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

sh $HOME/.local/bin/greetings_stardrop.sh

starship init fish | source

##### ALIASES #####
alias lsl='ls -lAgoh --color=auto --group-directories-first --time-style=locale'
alias dots='cd ~/dotfiles'
alias pdftk='java -jar $HOME/.local/bin/pdftk-all.jar'

alias nv='nvim'
alias nl='NVIM_APPNAME="nvim-lazyvim" nvim'
alias nk='NVIM_APPNAME="nvim-kickstart" nvim'
