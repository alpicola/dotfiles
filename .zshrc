export LANG=ja_JP.UTF-8

export PATH=~/bin:/opt/local/bin:/opt/local/sbin:/Developer/SDKs/flex_sdk_4/bin:/usr/local/mysql/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

export HREF_DATADIR=/usr/share/href
export GISTY_DIR=~/gist

export PAGER=lv
export LV='-Ou8 -c'
export EDITOR=vim

export MAILCHECK=3600

export __CF_USER_TEXT_ENCODING='0x1F5:0x08000100:14'

export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

# export LS_COLORS='di=38;5;101:ln=38;5;101:so=38;5;228:ex=38;5;172:bd=38;5;167:cd=38;5;179'

bindkey -e

setopt extended_glob

setopt auto_pushd

# ディレクトリ名だけで cd
setopt auto_cd

# ヒストリは上書きせず追加で
setopt append_history

# 連続する同じコマンドは記録しない
setopt hist_ignore_dups

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

alias rsync='rsync --exclude ".DS_Store"'
alias ls='ls -FG'
alias ll='ls -l'

alias -g V="| vim -R -"
alias -g L="| $PAGER"
alias -g G="| grep"
alias -g C="| pbcopy"

alias flog="tail -f ~/Library/Preferences/Macromedia/Flash\ Player/Logs/flashlog.txt | nkf -u -w"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

if [[ -s /Users/ryo/.rvm/scripts/rvm ]]; then source /Users/ryo/.rvm/scripts/rvm; fi  
