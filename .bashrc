#
# ~/.bashrc
#
#

function _fish_collapsed_pwd() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}
 
PROMPT_COMMAND=__prompt_command    # Function to generate PS1 after CMDs
 
__prompt_command() {
    local EXIT="$?"                # This needs to be first
    PS1=""
 
    local RCol='\[\e[0m\]'
 
    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    if [ $EXIT != 0 ]; then
        PS1+="${Red}\u${RCol}"        # Add red if exit code non 0
    else
        PS1+="${Gre}\u${RCol}"
    fi
 
    PS1+="${RCol}@${BBlu}\h ${Pur}$(_fish_collapsed_pwd)${RCol} "
    export PROMPT='%F{135}%n%f@%F{166}%m%f %F{2}$(_fish_collapsed_pwd)%f> '
}

[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach
[[ ${BLE_VERSION-} ]] && ble-attach

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

complete -cf doas

# alias
##cd/ls
alias ll='ls -lrt --color'
alias la='ls -lha --color'
alias l='cd ..'
alias lr='cd -'
##aur
alias pi='paru -S'
alias prs='paru -Qqdt | paru -Rs -'
##fastfetch
alias fath='fastfetch'
##cat
alias cat='bat'
