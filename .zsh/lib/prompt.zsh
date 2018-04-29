# autoload -U add-zsh-hook
autoload -Uz vcs_info

# enable VCS systems you use
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:prompt:*' check-for-changes true

setopt prompt_subst
autoload -U promptinit
promptinit

ZLE_RPROMPT_INDENT=0

# Look at http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
# for mor options
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{124}*%F{yellow}'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr ' %F{green}*%F{yellow}'   # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '%F{yellow}[%s:%a|%b%c%u]%f'
zstyle ':vcs_info:*' formats '%F{yellow}[%s:%b%c%u]%f'

zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }


### Left prompt
PROMPT=''

# If it's an SSH connection, show the user and host
if [[ "$SSH_CONNECTION" != '' ]]; then
    # If the user is root, show it in red
    if [[ $UID -eq 0 ]]; then
        PROMPT+='%F{124}'
    else
        PROMPT+='%F{green}'
    fi

    PROMPT+='%n@%m%f '
else
    # If the user is root, show the username in red
    if [[ $UID -eq 0 ]]; then
        PROMPT+='%F{124}'
    fi

    PROMPT+='%n%f '
fi

# Show the path in blue
PROMPT+='%F{blue}%~%f '

# The prompt turns red if the previous command wasn't successfull
PROMPT+='%(?.%F{green}.%F{red})${PROMPT_SYMBOL:-❱}%f '


### Right prompt (VCS)
function check_git_hide_status() {
    if [[ "$(command git config --get zsh-git.hide-status 2>/dev/null)" != "1" ]];then
        RPROMPT='${vcs_info_msg_0_}'
    else
        RPROMPT='foo'
    fi
}
# Call the function on every directory change to check its git status and config
chpwd_functions=(${chpwd_functions[@]} "check_git_hide_status")
# Call it once after login to get the status of the home directory
check_git_hide_status
