if [ "x$OH_MY_ZSH_HG" = "x" ]; then
    OH_MY_ZSH_HG="hg"
fi

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    $OH_MY_ZSH_HG prompt --angle-brackets "\
<%{$fg[magenta]%}<root|basename>%{$reset_color%}@><%{$fg[red]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null && echo -e "\n%{$reset_color%}"
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$' && return
    echo '○'
}

PROMPT=$'%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[green]%}$(box_name)%{$reset_color%}:$(hg_prompt_info)$(git_prompt_info)$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%} $(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX="@%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="\n%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
RPROMPT='${return_status}%{$reset_color%}'
