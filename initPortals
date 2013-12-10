#!/bin/bash

# Creates the file that stores the current positions of blue and orange portals

# change this variable in order to change the path of the file that saves the 
# state of the portals
PORTAL_FILE=~/.state.portal

# create the file if it is not there. Empty string means that the portal is
# not open
if [ ! -f $PORTAL_FILE ]
then
  echo "ORANGE=" >> $PORTAL_FILE
  echo "BLUE=" >> $PORTAL_FILE
fi
