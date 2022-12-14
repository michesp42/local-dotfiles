#!/usr/bin/env bash

#
# ~/.bash_profile
#

# sanitize home as much as possible
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export HISTFILE="$XDG_STATE_HOME"/bash/history
export HISTCONTROL=ignoredups:erasedups # no duplicate entries

# xdg with various programs
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export KICAD_SYMBOL_DIR="/usr/share/kicad/symbols"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export LEIN_HOME="$XDG_DATA_HOME"/lein
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export PYLINTRC="$XDG_CONFIG_HOME"/pylint/pylintrc
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export WORKON_HOME="$XDG_DATA_HOME"/virtualenvs
export WGETRC="$XDG_CONFIG_HOME"/wgetrc

# xdg with vim config
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

# xdg with X11 config
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export USERXSESSION="$XDG_CACHE_HOME"/X11/xsession
export USERXSESSIONRC="$XDG_CACHE_HOME"/X11/xsessionrc
export ALTUSERXSESSION="$XDG_CACHE_HOME"/X11/Xsession
export ERRFILE="$XDG_CACHE_HOME"/X11/xsession-errors
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

# user preference
export EDITOR=vim
export BROWSER=brave
export TERMINAL=alacritty

# export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME"/bat/bat.conf
export QT_STYLE_OVERRIDE=kvantum
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d8dee9,bg:#2e3440,hl:#81a1c1
  --color=fg+:#d8dee9,bg+:#3b4252,hl+:#81a1c1
  --color=info:#ebcb8b,prompt:#a3be8c,pointer:#bf616a
  --color=marker:#bf616a,spinner:#b29e75,header:#4c566a'

# set pager colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;36m' # options?
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m' # text at the bottom
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;35m' # key terms?

# opam configuration
test -r /home/mice/.opam/opam-init/init.sh && . /home/mice/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[ -d "$HOME"/.local/bin ] && PATH="$PATH:$HOME/.local/bin"
[ -d "$HOME"/.local/scripts ] && PATH="$PATH:$HOME/.local/scripts"
[ -d "$GOPATH"/bin ] && PATH="$PATH:$GOPATH/bin"
[ -d "$HOME"/.dotnet/tools/ ] && PATH="$PATH:$HOME/.dotnet/tools"
[ -d "$XDG_DATA_HOME"/cargo/bin/ ] && PATH="$PATH:$XDG_DATA_HOME/cargo/bin"
[ -d "$XDG_DATA_HOME"/gem/ruby/3.0.0/bin ] && PATH="$PATH:$XDG_DATA_HOME/gem/ruby/3.0.0/bin"
[ -d "$XDG_DATA_HOME"/npm/bin ] && PATH="$PATH:$XDG_DATA_HOME/npm/bin/"
[ -d "$HOME/.opam/default/bin/" ] && PATH="$PATH:$HOME/.opam/default/bin/"

# shellcheck source=/home/mice/.bashrc
[ -f ~/.bashrc ] && . ~/.bashrc

# autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  pgrep bspwm || exec startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi
