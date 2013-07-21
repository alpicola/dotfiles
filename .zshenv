typeset -U path
path=(
    $HOME/bin(N-/)
    $HOME/.cabal/bin(N-/)
    $HOME/Library/Haskell/bin(N-/)
    /opt/local/bin(N-/)
    /usr/local/bin(N-/)
    /usr/sbin(N-/)
    /usr/bin(N-/)
    /sbin(N-/)
    /bin(N-/)
)

typeset -U manpath
manpath=(
    /opt/local/share/man(N-/)
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
)

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=(
    /opt/local/sbin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
)

if type lv > /dev/null 2>&1; then
  PAGER=lv
else
  PAGER=less
fi
export PAGER
export LV='-c -l'

export EDITOR=vim

if [[ -e "$HOME/.zshenv.local" ]]; then
    source "$HOME/.zshenv.local"
fi
