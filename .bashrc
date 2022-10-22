#!/usr/bin/env bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000

set -o noclobber # disable overwriting files via `>`, use `>|` instead

### SHOPT
shopt -s histappend     # append to the history file, don't overwrite it
shopt -s globstar       # set the pattern `**` for pathname expansion context to match all files and zero or more directories and subdirectories.
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # includes filenames beginning with a `.' in the results of pathname expansion
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

# enable scrollback in vterm inside emacs
if [ "$INSIDE_EMACS" = "vterm" ]; then
  function clear() {
    vterm_printf "51;Evterm-clear-scrollback"
    tput clear
  }
fi

# limit number of directories shown in the prompt
# now `\w` will show something like `~/.../path/to/dir`
PROMPT_DIRTRIM=3

# if not in linux console, load the custom prompt
# otherwise just load custom colors for the linux console
if [ "$TERM" != "linux" ]; then

  # Using this function the bash prompt will display the current working
  # directory (with an icon that warns if outside of user's home directory),
  # git branch and additional git information, and exit status
  #
  # CREDIT: This function for the prompt is just a modified version of the gist
  # from this link: `https://gist.github.com/chiuki/3430887`.
  function __prompt_command {
    # save the exit status of the last run command before any command inside
    # this function runs
    local exitstatus="$?"

    # define shorthands for the colors
    local RED="\[\033[1;31m\]"
    local GREEN="\[\e[32;1m\]"
    local BLUE="\[\e[34;1m\]"
    local PURPLE="\[\e[35;1m\]"
    local CYAN="\[\e[36;1m\]"
    local YELLOW="\[\e[33;1m\]"
    local OFF="\[\033[m\]"

    # get the git branch if inside a git repo
    local branch
    branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)

    if [ -n "$branch" ]; then
      branch=" ${PURPLE}on  ${branch}"

      # get more git information if any, like the number of modified, deleted,
      # untracked, added, and unmerged files.
      local changes
      changes=$(git status -s 2>/dev/null | wc -l)

      if [ "$changes" -gt 0 ]; then
        local git_status
        local modified
        local deleted
        local dirty=" ${BLUE}[${OFF} "

        git_status="$(git status -s)"
        modified=$(echo "$git_status" | grep -c -E "^ *M")
        deleted=$(echo "$git_status" | grep -c -E "^ *D")
        untracked=$(echo "$git_status" | grep -c -E "^\?\?")
        added=$(echo "$git_status" | grep -c -E "^A")
        unmerged=$(echo "$git_status" | grep -c -E "^U")
        renamed=$(echo "$git_status" | grep -c -E "^R")

        [ "$modified" -gt 0 ] && dirty+="${GREEN}M$modified${OFF} "
        [ "$deleted" -gt 0 ] && dirty+="${RED}D$deleted${OFF} "
        [ "$untracked" -gt 0 ] && dirty+="${YELLOW}?$untracked${OFF} "
        [ "$added" -gt 0 ] && dirty+="${PURPLE}A$added${OFF} "
        [ "$unmerged" -gt 0 ] && dirty+="${CYAN}U$unmerged${OFF} "
        [ "$renamed" -gt 0 ] && dirty+="${CYAN}R$renamed${OFF} "

        dirty+="${BLUE}]${OFF}"
      fi
    fi

    # add warning icon to prompt if there are changes in dotfiles bare
    # repository
    local dots_changed
    local dots_icon

    dots_changed=$(/usr/bin/git --git-dir="$HOME"/.local/dotfiles \
      --work-tree="$HOME" status -s)
    [ -n "$dots_changed" ] && dots_icon=" "

    # define prompt with path info `\w`, git branch, and additional git
    # information
    local prompt="${YELLOW}${dots_icon}${OFF}${BLUE}\w${OFF}${PURPLE}\
${branch}${OFF}${dirty}"

    # prefix icon depends on whether $USER is under its home directory or not
    local ICON_PREFIX
    if ! pwd | grep -q "$USER"; then
      ICON_PREFIX="${RED}${OFF} "
    fi

    # augment the prompt with an icon that changes color depending on the
    # `exitstatus` of the last command ran
    #
    # CYAN icon             -- if exit success
    # (exitstatus) RED icon -- if exit failure
    local ICON="➜" # INFO: Other icons -         λ     ➜
    if [ "$exitstatus" -eq 0 ]; then
      PS1="${prompt}\n${ICON_PREFIX}${CYAN}${ICON} ${OFF}"
    else
      PS1="${prompt}\n"
      PS1+="${RED}(${OFF}${YELLOW}$exitstatus${OFF}${RED})${OFF} "
      PS1+="${ICON_PREFIX}${RED}${ICON} ${OFF}"
    fi
  }

  PROMPT_COMMAND=__prompt_command
else
  # INFO: colors format for linux console generated using
  # `https://terminal.sexy` with the onehalf dark palette.
  /bin/echo -e "
  \e]P0282c34
  \e]P1e06c75
  \e]P298c379
  \e]P3e5c07b
  \e]P461afef
  \e]P5c678dd
  \e]P656b6c2
  \e]P7dcdfe4
  \e]P8282c34
  \e]P9e06c75
  \e]PA98c379
  \e]PBe5c07b
  \e]PC61afef
  \e]PDc678dd
  \e]PE56b6c2
  \e]PFdcdfe4
  "
  clear

  GREEN="\[\e[32;1m\]"
  BLUE="\[\e[34;1m\]"
  PURPLE="\[\e[35;1m\]"
  CYAN="\[\e[36;1m\]"
  OFF="\[\033[m\]"

  PS1="${BLUE}\u${OFF}@${PURPLE}\h${OFF} ${CYAN}\w${OFF}\n${BLUE}\$${OFF} "
fi

# shellcheck source=/home/mice/.bash_aliases
[ -r ~/.bash_aliases ] && . ~/.bash_aliases # load user's custom aliases
