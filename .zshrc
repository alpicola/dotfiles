export LANG=en_US.UTF-8
# export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

bindkey -e

# 履歴検索
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

setopt extended_glob

setopt auto_pushd

# ディレクトリ名だけで cd
setopt auto_cd

# ヒストリは上書きせず追加で
setopt append_history

# 既にヒストリにあるコマンドは古い方を削除
setopt hist_ignore_all_dups

# 余計なスペースを削除
setopt hist_reduce_blanks

# シェルのプロセスごとに履歴を共有
setopt share_history

# 訂正
setopt correct

# 日本語表示
setopt print_eight_bit

# ビープ音
setopt no_beep

setopt ignoreeof

# 補完

# 補完候補一覧で ls -F のように種類を表示
setopt list_types

autoload -U compinit
compinit -u

# 補完候補を動き回る
zstyle ':completion:*:default' menu select=1
# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補の色づけ
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# プロンプト

# 色付き
autoload -U colors && colors
setopt prompt_subst

local DEFAULT=$'%{[m%}'
local BLUE=$'%{[34m%}'
local RED=$'%{[31m%}'
local YELLOW=$'%{[33m%}'
local ERROR=$'%{[31m%}%{$bg[magenta]%}'

# 終了ステータスが 0 でなければ終了ステータスを表示する。
PROMPT="%(?..${ERROR}exit %?${DEFAULT}
)${YELLOW}%#${DEFAULT} "

# カレントディレクトリを短縮表示
# http://0xcc.net/blog/archives/000032.html
RPROMPT="${BLUE}[%(5~,%-2~/.../%2~,%~)]${DEFAULT}"

autoload -Uz zmv
alias zmv='noglob zmv -W'

alias rsync='rsync --exclude ".DS_Store"'
alias ls='ls -FG'
alias ll='ls -l'

enter() {
    if [[ $#BUFFER -eq 0 ]]; then
        echo
        ls
        zle reset-prompt
    else
        zle accept-line
    fi
}
zle -N enter
bindkey "^M" enter

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

_Z_CMD=j
source ~/.zsh/z.sh
precmd() {
    _z --add "$(pwd -P)"
}

# http://unix.stackexchange.com/questions/41214/how-can-i-cd-to-the-previous-next-sibling-directory
prev () {
    # default to current directory if no previous
    local prevdir="./"
    local cwd=${PWD##*/}
    if [[ -z $cwd ]]; then
        # $PWD must be /
        echo 'No previous directory.' >&2
        return 1
    fi
    for x in ../*/; do
        if [[ ${x#../} == ${cwd}/ ]]; then
            # found cwd
            if [[ $prevdir == ./ ]]; then
                echo 'No previous directory.' >&2
                return 1
            fi
            cd "$prevdir"
            return
        fi
        if [[ -d $x ]]; then
            prevdir=$x
        fi
    done
    # Should never get here.
    echo 'Directory not changed.' >&2
    return 1
}
next () {
    local foundcwd=
    local cwd=${PWD##*/}
    if [[ -z $cwd ]]; then
        # $PWD must be /
        echo 'No next directory.' >&2
        return 1
    fi
    for x in ../*/; do
        if [[ -n $foundcwd ]]; then
            if [[ -d $x ]]; then
                cd "$x"
                return
            fi
        elif [[ ${x#../} == ${cwd}/ ]]; then
            foundcwd=1
        fi
    done
    echo 'No next directory.' >&2
    return 1
}
