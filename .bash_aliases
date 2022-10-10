#
# ~/.bash_aliases
#

alias dots='/usr/bin/git --git-dir="$HOME"/.local/dotfiles --work-tree="$HOME"'

if [ "$TERM" != "linux" ]; then

  # use `exa` as `ls` if it's installed
  if command -v exa &>/dev/null; then
    alias ls='exa --icons --group-directories-first'
    alias tree='exa --icons --tree'
  fi

  if command -v bat &>/dev/null; then
    alias less='bat --plain'        # less but with syntax highlighting
    alias cat='bat --plain --plain' # cat but with syntax highlighting
  fi

  if command -v yt-dlp &>/dev/null; then
    # download audio from youtube in mp3 format
    alias yta='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" \
--extract-audio --audio-format mp3'

    # download youtube playlist as mp3 audio
    alias ytap='yt-dlp --yes-playlist --ignore-errors --output \
"%(title)s.%(ext)s" --extract-audio --audio-format mp3'
  fi

  if command -v xclip &>/dev/null; then
    # copy selection from stdout to clipboard
    alias cin='xclip -selection clipboard -i'

    # output selection from clipboard to stdout
    alias cout='xclip -selection clipboard -o'

    # find files and copy the selected file path to clipboard
    if [ command -v fd &>/dev/null -a command -v fzf &>/dev/null ]; then
      alias cpp="fd --type file | fzf | sed 's/^..//' | tr -d '\n' | xclip \
-selection clip"
    fi
  fi

else

  alias ls='ls --color=auto --group-directories-first'

fi
