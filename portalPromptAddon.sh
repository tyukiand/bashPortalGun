#!/bin/bash

# this script returns a colored string which shows if an 
# open portal is in the current working directory.
#
# Nice to have in the prompt :)
# 
# To add a portal-indicator to your prompt permanently, you have to
# update your ~/.bashrc, for example, you could add following line:
#
# export PROMPT_COMMAND='export PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h `portalPromptAddon.sh true` \[\033[01;34m\]\w \n\[\033[00m\]\$ "'
# The important part is in the `backticks`: here we call `portalPromptAddon.sh` which returns the 
# information about open portals in the current directory.
#
# This will upgrade your $PS1 (prompt) every time you execute a command in a bash 
# (or just press enter to update the indicator).
#
# After this, your prompt will look like that:
#
# username@host [blue/orange] ~/your/path
# $ your commands
#
# Remember that you have to restart bash or source .bashrc to make the changes visible.
# Just experiment a little bit, adjust it until it suits your needs (I mean the prompt,
# not this script, you can't do much here anyway...)

# load functions
source portalUtils.sh

# parse the input: show target true or not?
SHOW_TARGET=$1

function showTarget {
  LINK=$1
  if [ "$SHOW_TARGET" == "true" ]
  then
    printf " -> $(basename $(readlink "$LINK"))"
  fi
}

# check if the link files exist here, print corresponding colored line
blueLink=$(portalLinkName blue)
orangeLink=$(portalLinkName orange)

if [ -L "$blueLink" ] 
then
  printf "\[\033[01;36m\][blue$(showTarget [blue])]"
elif [ -L "$orangeLink" ]
then 
  printf "\[\033[01;33m\][orange$(showTarget [orange])]"
fi
