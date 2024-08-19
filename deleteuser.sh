#!/bin/bash

while true; do
    # Prompt for the username to delete
    username=$(whiptail --inputbox "Enter username to delete:" 8 39 --title "Delete User" 3>&1 1>&2 2>&3)

    # Check if the user pressed Cancel (exit status non-zero)
    if [ $? -ne 0 ]; then
        # User pressed Cancel, return to the main menu or exit
        break
    fi

    # Check if the input is empty
    if [ -z "$username" ]; then
        whiptail --msgbox "Username cannot be empty. Please try again." 8 39 --title "Error"
    else
        # Check if the user exists
        if id "$username" &>/dev/null; then
            # Delete the user
            sudo userdel "$username"
            if [ $? -eq 0 ]; then
                whiptail --msgbox "User $username deleted successfully." 8 39 --title "Success"
            else
                whiptail --msgbox "Failed to delete user $username. Please check for any issues." 8 39 --title "Error"
            fi
            break
        else
            whiptail --msgbox "User $username does not exist." 8 39 --title "Error"
        fi
    fi
done
