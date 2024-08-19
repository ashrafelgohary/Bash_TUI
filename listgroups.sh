#!/bin/bash

# Get the list of groups from /etc/group
groups=$(tail /etc/group |cut -d: -f1 )
echo "$groups" > text_box

# Display the list in a scrollable textbox
whiptail --title "List Groups" --textbox text_box 20 78
