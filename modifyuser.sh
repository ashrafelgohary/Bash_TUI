#!/bin/bash

while true; do
    # Prompt for the username to modify
    username=$(whiptail --inputbox "Enter username to modify:" 8 39 --title "Modify User" 3>&1 1>&2 2>&3)
    
    # Check if the user pressed Cancel (exit status non-zero)
    if [ $? != 0 ]; then
        echo "Operation cancelled. Exiting..."
        exit 1
    fi

    # Check if the input is empty
    if [ -z "$username" ]; then
        whiptail --msgbox "Username cannot be empty. Please try again." 8 39 --title "Error"
        continue
    fi

    # Check if the user exists
    if id "$username" &>/dev/null; then
        # Display user information
        uid=$(id -u "$username")
        gid=$(id -g "$username")
        groups=$(id -Gn "$username")
        expiry_date=$(chage -l "$username")
        
        user_info="User: $username\nUID: $uid\nGID: $gid\nGroups: $groups\nExpiry Date: $expiry_date\n"
        
        whiptail --msgbox "$user_info" 20 78 --title "User Information"
        
        # Prompt for modification options
        options=$(whiptail --title "Modify User $username" --menu "Please select what you want to do for user $username" 15 60 6 \
        "1" "Change shell" \
        "2" "Change UID" \
        "3" "Change GID" \
        3>&1 1>&2 2>&3)

        # Check if the user pressed Cancel (exit status non-zero)
        if [ $? != 0 ]; then
            echo "Operation cancelled. Exiting..."
            exit 1
        fi

        case $options in
            "1")
                # Change the user shell
                shell=$(whiptail --inputbox "Enter new shell for user $username (e.g., /bin/bash):" 8 39 --title "Change Shell" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$shell" ]; then
                    whiptail --msgbox "Shell cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi
                
                if sudo usermod -s "$shell" "$username"; then
                    whiptail --msgbox "Shell for user $username changed to $shell." 8 39 --title "Success"
                else
                    whiptail --msgbox "Failed to change shell for user $username. Please check for any issues." 8 39 --title "Error"
                fi
                ;;
            "2")
                # Change the user UID
                new_uid=$(whiptail --inputbox "Enter new UID for user $username:" 8 39 --title "Change UID" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$new_uid" ]; then
                    whiptail --msgbox "UID cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi
                
                if [[ ! "$new_uid" =~ ^[0-9]+$ ]] || id -u "$new_uid" &>/dev/null; then
                    whiptail --msgbox "Invalid UID. It must be a number and not already in use." 8 39 --title "Error"
                    continue
                fi
                
                if sudo usermod -u "$new_uid" "$username"; then
                    whiptail --msgbox "UID for user $username changed to $new_uid." 8 39 --title "Success"
                else
                    whiptail --msgbox "Failed to change UID for user $username. Please check for any issues." 8 39 --title "Error"
                fi
                ;;
            "3")
                # Change the user GID
                new_gid=$(whiptail --inputbox "Enter new GID for user $username:" 8 39 --title "Change GID" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$new_gid" ]; then
                    whiptail --msgbox "GID cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi
                
                if [[ ! "$new_gid" =~ ^[0-9]+$ ]] || getent group "$new_gid" > /dev/null; then
                    whiptail --msgbox "Invalid GID. It must be a number and not already in use." 8 39 --title "Error"
                    continue
                fi
                
                if sudo usermod -g "$new_gid" "$username"; then
                    whiptail --msgbox "GID for user $username changed to $new_gid." 8 39 --title "Success"
                else
                    whiptail --msgbox "Failed to change GID for user $username. Please check for any issues." 8 39 --title "Error"
                fi
                ;;
            *)
                whiptail --msgbox "Invalid option selected. Please try again." 8 39 --title "Error"
                ;;
        esac
    else
        whiptail --msgbox "User $username does not exist. Please choose another user." 8 39 --title "Error"
    fi
done
