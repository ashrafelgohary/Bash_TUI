#!/bin/bash

# Get the list of users from /etc/passwd
users=$(tail /etc/passwd |cut -d: -f1 )
echo "$users" > text_box

# Display the list in a scrollable textbox
whiptail --title "List Users" --textbox text_box 20 78
