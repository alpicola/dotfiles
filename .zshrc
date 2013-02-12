export LANG=ja_JP.UTF-8
# export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

bindkey -e

# 履歴検索
autoload history-search-end
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
if [ "$TERM" = "xterm-256color" ]; then
	local BLUE=$'%{[38;5;110m%}'
	local RED=$'%{[38;5;209m%}'
	local YELLOW=$'%{[38;5;179m%}'
	local ERROR=$'%{[38;5;173m%}%{[48;5;52m%}'
else
	local BLUE=$'%{[34m%}'
	local RED=$'%{[31m%}'
	local YELLOW=$'%{[33m%}'
	local ERROR=$'%{[31m%}%{$bg[magenta]%}'
fi

# 終了ステータスが 0 でなければ終了ステータスを表示する。
PROMPT="%(?..${ERROR}exit %?${DEFAULT}
)${YELLOW}%#${DEFAULT} "

# カレントディレクトリを短縮表示
# http://0xcc.net/blog/archives/000032.html
RPROMPT="${BLUE}[%(5~,%-2~/.../%2~,%~)]${DEFAULT}"

if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		echo -n "\e]1;$cmd[1]:t\a"
		echo -n "\e]2;zsh\a"
		# echo -n "\e]2;$PWD — $cmd[1]:t\a"
	}

	precmd() {
		pwd=`pwd | perl -pe 's!^$ENV{'HOME'}!~!;s!^(.{5,}?/)(.+)(/.{10,})$!$1...$3!'`
		echo -n "\e]1;${pwd}\a"
		echo -n "\e]2;zsh\a"
	}
fi

autoload -Uz zmv
alias zmv='noglob zmv -W'

alias rsync='rsync --exclude ".DS_Store"'
alias ls='ls -FG'
alias ll='ls -l'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

_Z_CMD=j
source ~/.zsh/z.sh
precmd() {
    _z --add "$(pwd -P)"
}

function md2pdf() {
    for i in $@; do;
        pandoc $i -o ${i:r}.pdf --latex-engine=lualatex -V documentclass=ltjarticle -V geometry=top=30truemm,bottom=30truemm,left=25truemm,right=25truemm
    done;
}

if [[ -s /Users/ryo/.rvm/scripts/rvm ]]; then source /Users/ryo/.rvm/scripts/rvm; fi  
