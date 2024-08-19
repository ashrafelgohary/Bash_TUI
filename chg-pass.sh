#!/bin/bash

username=$(whiptail --inputbox "Enter username to change password:" 8 39 --title "Change Password" 3>&1 1>&2 2>&3)

if [ $? -ne 0 ]; then
    exit 1  # If Cancel is pressed, exit the script
fi

if [ -z "$username" ]; then
    whiptail --msgbox "Username cannot be empty. Please try again." 8 39 --title "Error"
    exit 1
fi

if id "$username" &>/dev/null; then
    # Prompt for the password
    password=$(whiptail --passwordbox "Enter the new password for $username:" 8 39 --title "Set Password" 3>&1 1>&2 2>&3)

    # Check if the user pressed Cancel
    if [ $? -ne 0 ]; then
        # User pressed Cancel, do not change password and return to the main menu
        whiptail --msgbox "Password change for $username was cancelled." 8 39 --title "Attention"
        exit 0
    fi

    # Set the user's password
    echo $password |sudo passwd    --stdin $username


    if [ $? -eq 0 ]; then
        whiptail --msgbox "Password for user $username changed successfully." 8 39 --title "Success"
    else
        whiptail --msgbox "Failed to change password for user $username. Please check for any issues." 8 39 --title "Error"
    fi
else
    whiptail --msgbox "User $username does not exist." 8 39 --title "Error"
fi
