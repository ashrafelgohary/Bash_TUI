#!/bin/bash

while true; do
    # Prompt for the group name to delete
    groupname=$(whiptail --inputbox "Enter group name to delete:" 8 39 --title "Delete Group" 3>&1 1>&2 2>&3)

    # Check if the user pressed Cancel (exit status non-zero)
    if [ $? -ne 0 ]; then
        # User pressed Cancel, return to the main menu or exit
        break
    fi

    # Check if the input is empty
    if [ -z "$groupname" ]; then
        whiptail --msgbox "Group name cannot be empty. Please try again." 8 39 --title "Error"
    else
        # Check if the group exists
        if getent group "$groupname" > /dev/null 2>&1; then
            # Try to delete the group
            sudo groupdel "$groupname"
            if [ $? -eq 0 ]; then
                whiptail --msgbox "Group $groupname deleted successfully." 8 39 --title "Success"
            else
                # If deletion fails, show an error and suggest retrying
                whiptail --msgbox "Failed to delete group $groupname. Please ensure no other processes are modifying groups and try again later." 8 39 --title "Error"
            fi
        else
            whiptail --msgbox "Group $groupname does not exist." 8 39 --title "Error"
        fi
    fi

    # Ask if the user wants to delete another group or exit
    continue_choice=$(whiptail --yesno "Do you want to delete another group?" 8 39 --title "Continue?" 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        # User chose "No", break the loop to return to the main menu or exit
        break
    fi
done
