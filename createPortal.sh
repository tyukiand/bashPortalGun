#!/bin/bash

# Places the portal of thisColor in newPosition.
# Creates a link called [thisColor] in newPosition.
# This link points to the directory where the other portal is.

# read where the portal state file is, create one if necessary
# it initialises the $PORTAL_FILE variable.
source initPortals.sh

# load functions
source portalUtils.sh

# read the new position of the portal, check if it's a directory
# (otherwise propose to use gray rigolith gel?)
newPosition="$1"
if [ -z "$newPosition" ] 
then
  newPosition=`pwd`
fi
newPosition=`readlink -f "$newPosition"`

if ! [ -d "$newPosition" ]
then
  echo "Cannot create a portal on '${newPosition}', it's not a directory. "
  exit 1
fi

thisColor=$2
otherColor=$3

# read the positions of portals from the $PORTAL_FILE
thisPosition=$(readPosition $thisColor)
otherPosition=$(readPosition $otherColor)

# names of the actual link files
thisLink=$(portalLinkName $thisColor)
otherLink=$(portalLinkName $otherColor)

# close the old portals, don't touch the entries in $PORTAL_FILE
closePortal $thisColor removeOnlySymlink
closePortal $otherColor removeOnlySymlink

# update the path to the new portal in the $PORTAL_FILE
writePosition $thisColor "$newPosition"

# create link files with updated pathes if possible
# (note: the opposite portal could be closed)
if [ -n "$otherPosition" ] 
then 
  ln -s "$otherPosition" "${newPosition}/${thisLink}"
  ln -s "$newPosition" "${otherPosition}/${otherLink}"
else
  # create a broken link for now. It's not very useful, but it reminds you 
  # of the position of the first portal
  ln -s "/.portal.not.open" "${newPosition}/${thisLink}"
fi
