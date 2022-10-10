#
# ~/.bash_aliases
#

alias dots='/usr/bin/git --git-dir="$HOME"/.local/dotfiles --work-tree="$HOME"'

if [ "$TERM" != "linux" ]; then

  # an almost better cd command
  bcd() {
    cd $(/usr/bin/ls -1d -- .*/ */ | tr -d '/' | fzf --height=~70% \
      --border=rounded --reverse --prompt=' ' --pointer='')
  }

  # add bling to fzf
  alias fzf="(fzf --height=~70% --border=rounded --reverse --prompt=' ' \
--pointer='')"

  #
  # fancy alternatives for default programs
  #

  alias ls='exa --icons --group-directories-first' # ls but with icons
  alias tree='exa --icons --tree'                  # tree but with icons
  alias less='bat --plain'                         # less but with syntax highlighting
  alias cat='bat --plain --plain'                  # cat but with syntax highlighting

  #
  # yt-dlp related aliases
  #

  # download audio from youtube in mp3 format
  alias yta='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" \
--extract-audio --audio-format mp3'

  # download youtube playlist as mp3 audio
  alias ytap='yt-dlp --yes-playlist --ignore-errors --output \
"%(title)s.%(ext)s" --extract-audio --audio-format mp3'

  #
  # clipboard related aliases
  #

  alias cin='xclip -selection clipboard -i'  # copy selection from stdout to clipboard
  alias cout='xclip -selection clipboard -o' # output selection from clipboard to stdout

  # select a filepath and copy it to clipboard
  alias cpp="fd --type file | fzf | sed 's/^..//' | tr -d '\n' | xclip \
-selection clip"

else

  alias ls='ls --color=auto --group-directories-first'

fi
