#!/usr/bin/env bash

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# set the pattern `**` for pathname expansion context to match all files and
# zero or more directories and subdirectories.
shopt -s globstar

# disable overwriting files via `>`, use `>|` instead
set -o noclobber

# enable scrollback in vterm inside emacs
if [ "$INSIDE_EMACS" = "vterm" ]; then
  function clear() {
    vterm_printf "51;Evterm-clear-scrollback"
    tput clear
  }
fi

# Using this function the bash prompt will display the current working
# directory (with an icon that warns if outside of user's home directory), git
# branch and additional git information, and exit status
#
# CREDIT: This function for the prompt is just a modified version of the gist
# from this link: `https://gist.github.com/chiuki/3430887`.
function __prompt_command {
  # save the exit status of the last run command before any command inside this
  # function runs
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
  local branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
  if [ ! -z "$branch" ]; then
    branch=$(echo " ${PURPLE}on  ${branch}")
  fi

  # get more git information if any, like the number of modified, deleted,
  # untracked, added, and unmerged files.
  local changes=$(git status -s 2>/dev/null | wc -l)
  if [ "$changes" -eq 0 ]; then
    local dirty=""
  else
    local dirty=" ${BLUE}[${OFF} "

    local modified=$(git status -s | grep -e '^ M' | wc -l)
    local deleted=$(git status -s | grep -e '^ D' | wc -l)
    local untracked=$(git status -s | grep -e '^??' | wc -l)
    local added=$(git status -s | grep -e '^A' | wc -l)
    local unmerged=$(git status -s | grep -e '^U' | wc -l)

    [ "$modified" -gt 0 ] && dirty+="${GREEN}M$modified${OFF} "
    [ "$deleted" -gt 0 ] && dirty+="${RED}D$deleted${OFF} "
    [ "$untracked" -gt 0 ] && dirty+="${YELLOW}?$untracked${OFF} "
    [ "$added" -gt 0 ] && dirty+="${PURPLE}A$added${OFF} "
    [ "$unmerged" -gt 0 ] && dirty+="${CYAN}U$unmerged${OFF} "

    dirty+="${BLUE}]${OFF}"
  fi

  # define prompt with path info `\w`, git branch, and additional git
  # information
  local prompt="${BLUE}\w${OFF}${PURPLE}${branch}${OFF}${dirty}"

  # prefix icon depends on whether $USER is under its home directory or not
  local ICON_PREFIX=""
  if ! echo $(pwd) | grep -q "$USER"; then
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

# limit number of directories shown in the prompt
# now `\w` will show something like `~/.../path/to/dir`
PROMPT_DIRTRIM=3

# if not in linux console, load the custom prompt
# otherwise just load custom colors for the linux console
if [ "$TERM" != "linux" ]; then
  PROMPT_COMMAND=__prompt_command
else
  # INFO: colors format for linux console generated using
  # `https://terminal.sexy` with the nord color palette.
  /bin/echo -e "
  \e]P03b4252
  \e]P1bf616a
  \e]P2a3be8c
  \e]P3ebcb8b
  \e]P481a1c1
  \e]P5b48ead
  \e]P688c0d0
  \e]P7e5e9f0
  \e]P84c566a
  \e]P9bf616a
  \e]PAa3be8c
  \e]PBebcb8b
  \e]PC81a1c1
  \e]PDb48ead
  \e]PE8fbcbb
  \e]PFeceff4
  "
  clear
fi

# load user's custom aliases
[ -r ~/.bash_aliases ] && . ~/.bash_aliases
