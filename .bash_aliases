#!/usr/bin/env bash

#
# ~/.bash_aliases
#

# alias for my dotfiles git bare repository
alias dots='/usr/bin/git --git-dir="$HOME"/.local/dotfiles --work-tree="$HOME"'

# make the following commands interactive, i.e., prompt me for confirmation
# before performing their action especially when they are about to overwrite a
# file
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive=always'

# colorize the following commands
alias ip='ip --color=auto'
alias grep='grep --color=auto'

### yt-dlp

# download audio to various audio formats
alias yta-aac='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format aac'
alias yta-best='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format best'
alias yta-flac='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format flac'
alias yta-m4a='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format m4a'
alias yta-mp3='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'
alias yta-opus='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format opus'
alias yta-vorbis='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format vorbis'
alias yta-wav='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format wav'
alias ytv-best='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" -f bestvideo+bestaudio'

# download youtube playlist to various audio formats
alias ytap-aac='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format aac'
alias ytap-best='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format best'
alias ytap-flac='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format flac'
alias ytap-m4a='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format m4a'
alias ytap-mp3='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'
alias ytap-opus='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format opus'
alias ytap-vorbis='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format vorbis'
alias ytap-wav='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format wav'
alias ytvp-best='yt-dlp --yes-playlist --ignore-errors --output "%(title)s.%(ext)s" -f bestvideo+bestaudio'

# `transmission-remote` is too long to type for my slow hands
alias trrm='transmission-remote'

# aliases to check weather
weather() {
  [ -n "$1" ] && curl wttr.in/"$1"?0
}
export weather

forecast() {
  [ -n "$1" ] && curl wttr.in/"$1"
}
export forecast

### aliases to be load if not in linux console

if [ "$TERM" != "linux" ] && [ "$TERM" != "xterm-256color" ]; then

  # an almost better cd command
  bcd() {
    cd "$(/usr/bin/ls -1d -- .*/ */ | tr -d '/' | /usr/bin/fzf --height=~70% \
      --border=rounded --reverse --prompt=' ' --pointer='')" || return
  }
  export bcd

  # add bling to fzf
  alias fzf="(fzf --height=~70% --border=rounded --reverse --prompt=' ' \
--pointer='')"

  # fancy alternatives for default programs
  alias ls='exa --icons --group-directories-first' # ls but with icons
  alias tree='exa --icons --tree'                  # tree but with icons
  alias less='bat --plain'                         # less but with syntax highlighting
  alias cat='bat --plain --plain'                  # cat but with syntax highlighting

  # clipboard related aliases
  alias cin='xclip -selection clipboard -i'  # copy selection from stdout to clipboard
  alias cout='xclip -selection clipboard -o' # output selection from clipboard to stdout
  alias cpp="fd --type file | fzf | sed 's/^..//' | tr -d '\n' | xclip \
-selection clip" # select a filepath and copy it to clipboard

else

  alias ls='ls --color=auto --group-directories-first'

fi
