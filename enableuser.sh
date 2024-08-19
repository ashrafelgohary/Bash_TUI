#!/bin/bash

while true; do
    # Prompt for the username to enable
    username=$(whiptail --inputbox "Enter username to enable:" 8 39 --title "Enable User" 3>&1 1>&2 2>&3)

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
            # Enable the user account
            sudo usermod -U "$username"
            if [ $? -eq 0 ]; then
                whiptail --msgbox "User $username enabled successfully." 8 39 --title "Success"
            else
                whiptail --msgbox "Failed to enable user $username. Please check for any issues." 8 39 --title "Error"
            fi
        else
            whiptail --msgbox "User $username does not exist." 8 39 --title "Error"
        fi
    fi

    # Ask if the user wants to enable another user or exit
    continue_choice=$(whiptail --yesno "Do you want to enable another user?" 8 39 --title "Continue?" 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        # User chose "No", break the loop to return to the main menu or exit
        break
    fi
done

