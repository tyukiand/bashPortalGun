#!/bin/bash

# This file contains functions that are frequently used by other
# bash portal gun scripts



# Reads the position of the portal with the specified color from the
# $PORTAL_FILE (assumes that this variable is set)
#
# Returns: absolute path to directory where the portal is
function readPosition() {
  local color=$1 
  echo $(grep $color "$PORTAL_FILE" | cut -d'=' -f2)
}

# Updates position in the $PORTAL_FILE
#
# Parameters:
#   color - color of the portal
#   position - directory name where to move the portal
function writePosition() {
  local color=$1
  local position=$2
  sed -i "s,${color}=.*,${color}=${position},g" $PORTAL_FILE
}

# Returns the name of the link file (currently [blue], [orange])
function portalLinkName() {
  local color=$1
  printf "[${color,,}]"
}

# Removes a symlink file, checks whether it exists at all.
#
# Parameters: 
#   color - color of the portal
#   position - the folder where the symlink file is expected to be.
#   linkFileName - the name of the symlink
#
# Returns: 
#   Nothing
function closePortal() {
  local color=$1
  local position=$(readPosition $color)
  local linkFileName=$(portalLinkName $color)
  if [ -n "$position" ] && [ -L "${position}/${linkFileName}" ]
  then
    rm "${position}/${linkFileName}"
  fi

  sed -i "s,${color,,}=.*,${color,,}=,g" $PORTAL_FILE
}
