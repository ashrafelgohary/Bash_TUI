#!/bin/bash

while true; do
    # Prompt for group name
    groupname=$(whiptail --inputbox "Enter group name to add:" 8 39 --title "Add Group" 3>&1 1>&2 2>&3)

    # Check if the user pressed Cancel (exit status non-zero)
    if [ $? -ne 0 ]; then
        # User pressed Cancel, return to the main menu or exit
        break
    fi

    # Check if the input is empty
    if [ -z "$groupname" ]; then
        whiptail --msgbox "Group name cannot be empty. Please try again." 8 39 --title "Error"
    else
        # Check if the group already exists
        if getent group "$groupname" > /dev/null 2>&1; then
            whiptail --msgbox "Group $groupname already exists." 8 39 --title "Error"
        else
            # Add the group
            sudo groupadd "$groupname"
            if [ $? -eq 0 ]; then
                whiptail --msgbox "Group $groupname added successfully." 8 39 --title "Success"
            else
                whiptail --msgbox "Failed to add group $groupname." 8 39 --title "Error"
            fi
            break
        fi
    fi
done
