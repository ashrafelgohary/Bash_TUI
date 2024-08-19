#!/bin/bash
 while true; do
    username=$(whiptail --inputbox "Enter username to add:" 8 39 --title "Add User" 3>&1 1>&2 2>&3)

    # Check for cancel option (if user presses Cancel)
    if [ $? -ne 0 ]; then
        # User pressed Cancel, return to the main menu
        break
    fi
    # Check if the input is empty
    if [ -z "$username" ]; then
        whiptail --msgbox "Username cannot be empty. Please try again." 8 39 --title "Error"
    else
        # Check if the user exists
        if id "$username" &>/dev/null; then
            whiptail --msgbox "User $username already exists." 8 39 --title "Error"
        else
            # Add the user
            sudo useradd "$username"
            if [ $? -eq 0 ]; then
                # Prompt for the password
                password=$(whiptail --passwordbox "Enter password for $username:" 8 39 --title "Set Password" 3>&1 1>&2 2>&3)

                # Check for cancel option (if user presses Cancel)
                if [ $? -ne 0 ]; then
                    # User pressed Cancel, do not set password and return to the main menu
                    whiptail --msgbox "User $username added without setting a password." 8 39 --title "Success"
                    exit 0
                fi

                # Set the password for the user
                echo $password |sudo passwd    --stdin $username

                # Confirm that the user and password have been set
                whiptail --msgbox "User $username added and password set." 8 39 --title "Success"
            else
                whiptail --msgbox "Failed to add user $username." 8 39 --title "Error"
            fi
            break
        fi
    fi
done