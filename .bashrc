#
# ~/.bashrc

# Colours
TEXT_COLOUR='\e[38;5;203m' # for text
BG_COLOUR='\e[48;5;25m' # For background
CLOSING_COLOUR='\e[38;5;25m' # For text
COLOR_RESET='\e[0m' # back
TRIANGLE=$'\uE0B0'
STARTER=$'\uE0BE'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# when cleared, prompt shouldt have a newline on top
alias clear='PROMPT_COMMAND_ADDED= && clear'


PS1="\[${CLOSING_COLOUR}\]${STARTER}\[${BG_COLOUR}\]\[${TEXT_COLOUR}\]󱞪 \W \[${COLOR_RESET}\]\[${CLOSING_COLOUR}\]${TRIANGLE}\[${COLOR_RESET}\] "

# Add a newline after every command's output
PROMPT_COMMAND='if [ "$PROMPT_COMMAND_ADDED" != "true" ]; then PROMPT_COMMAND_ADDED=true; else echo; fi'


export PATH=/home/tgk/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/binle
