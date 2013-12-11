#!/bin/bash

# Places the portal of THIS_COLOR in NEW_POSITION.
# Creates a link called [THIS_COLOR_LOWERCASE] in NEW_POSITION.
# This link points to the directory where the other portal is.

NEW_POSITION="$1"
if [ -z "$NEW_POSITION" ] 
then
  NEW_POSITION=`pwd`
fi
NEW_POSITION=`readlink -f $NEW_POSITION`

if ! [ -d "$NEW_POSITION" ]
then
  echo "Cannot create a portal on '${NEW_POSITION}', it's not a directory. "
  exit 1
fi

THIS_COLOR=$2
OTHER_COLOR=$3
THIS_COLOR_LOWERCASE=$(echo $THIS_COLOR | tr '[:upper:]' '[:lower:]')
OTHER_COLOR_LOWERCASE=$(echo $OTHER_COLOR | tr '[:upper:]' '[:lower:]')

# read where the portal state file is, create one if necessary
source initPortals.sh

THIS_POSITION=$(grep $THIS_COLOR "$PORTAL_FILE" | cut -d'=' -f2)
OTHER_POSITION=$(grep $OTHER_COLOR "$PORTAL_FILE" | cut -d'=' -f2)

# The portal files are called [blue] and [orange]
# Since both start with a paren (uncommon for usual file names), 
# you never have to think hard what color the closest portal has:
# just type [ + Tab and let the auto-completion do it's work.
THIS_LINK="[${THIS_COLOR_LOWERCASE}]"
OTHER_LINK="[${OTHER_COLOR_LOWERCASE}]"

# removes a symlink file, checks whether it exists at all.
#
# POS is the folder where the symlink file is expected to be.
# LINK is the name of the symlink
function closePortal {
  POS=$1
  LINK=$2
  if [ -n "$POS" ] && [ -L "${POS}/${LINK}" ]
  then
    rm "${POS}/${LINK}"
  fi
}

# close the old portals
closePortal "$THIS_POSITION" $THIS_LINK
closePortal "$OTHER_POSITION" $OTHER_LINK

# update the path to the new portal in the $PORTAL_FILE
sed -i "s,${THIS_COLOR}=.*,${THIS_COLOR}=${NEW_POSITION},g" $PORTAL_FILE

# create link files with updated pathes if possible
# (note: the opposite portal could be closed)
if [ -n "$OTHER_POSITION" ] 
then 
  ln -s "$OTHER_POSITION" "${NEW_POSITION}/${THIS_LINK}"
  ln -s "$NEW_POSITION" "${OTHER_POSITION}/${OTHER_LINK}"
else
  # create a broken link for now. It's not very useful, but it reminds you 
  # of the position of the first portal
  ln -s "/.portal.not.open" \
    "${NEW_POSITION}/${THIS_LINK}"
fi
