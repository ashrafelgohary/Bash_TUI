#!/bin/bash

while true; do
    # Prompt for the username to disable
    username=$(whiptail --inputbox "Enter username to disable:" 8 39 --title "Disable User" 3>&1 1>&2 2>&3)

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
            # Disable the user account
            sudo usermod -L "$username"
            if [ $? -eq 0 ]; then
                whiptail --msgbox "User $username disabled successfully." 8 39 --title "Success"
            else
                whiptail --msgbox "Failed to disable user $username. Please check for any issues." 8 39 --title "Error"
            fi
        else
            whiptail --msgbox "User $username does not exist." 8 39 --title "Error"
        fi
    fi

    # Ask if the user wants to disable another user or exit
    continue_choice=$(whiptail --yesno "Do you want to disable another user?" 8 39 --title "Continue?" 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        # User chose "No", break the loop to return to the main menu or exit
        break
    fi
done
