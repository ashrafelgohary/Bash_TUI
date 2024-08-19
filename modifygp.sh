#!/bin/bash

while true; do
    # Prompt for the group name to modify
    modgroup=$(whiptail --inputbox "Please enter the group name to modify:" 8 39 --title "Modify Group" 3>&1 1>&2 2>&3)
    
    # Check if the user pressed Cancel (exit status non-zero)
    if [ $? != 0 ]; then
        echo "Operation cancelled. Exiting..."
        exit 1
    fi

    # Check if the input is empty
    if [ -z "$modgroup" ]; then
        whiptail --msgbox "Group name cannot be empty. Please try again." 8 39 --title "Error"
        continue
    fi

    # Check if the group exists
    if getent group "$modgroup" > /dev/null; then
        options=$(whiptail --title "Modify Group $modgroup" --menu "Please select what you want to do for group $modgroup" 15 60 6 \
        "1" "Change group name" \
        "2" "Change group ID" \
        "3" "Add users to group" \
        "4" "Remove users from group" \
        3>&1 1>&2 2>&3)

        # Check if the user pressed Cancel (exit status non-zero)
        if [ $? != 0 ]; then
            echo "Operation cancelled. Exiting..."
            exit 1
        fi

        case $options in
            "1")
                # Change the group name
                new_name=$(whiptail --inputbox "Enter new name for group $modgroup:" 8 39 --title "Change Group Name" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$new_name" ]; then
                    whiptail --msgbox "New group name cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi

                if sudo groupmod -n "$new_name" "$modgroup"; then
                    whiptail --msgbox "Group $modgroup has been renamed to $new_name." 8 39 --title "Success"
                else
                    whiptail --msgbox "Failed to rename group $modgroup. Please check for any issues." 8 39 --title "Error"
                fi
                ;;
            "2")
                # Change the group ID
                new_gid=$(whiptail --inputbox "Enter new GID for group $modgroup:" 8 39 --title "Change Group ID" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$new_gid" ]; then
                    whiptail --msgbox "GID cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi
                
                # Check if the GID is valid and not already in use
                if [[ ! "$new_gid" =~ ^[0-9]+$ ]] || getent group "$new_gid" > /dev/null; then
                    whiptail --msgbox "Invalid GID. It must be a number and not already in use." 8 39 --title "Error"
                    continue
                fi

                if sudo groupmod -g "$new_gid" "$modgroup"; then
                    whiptail --msgbox "Group $modgroup's GID has been changed to $new_gid." 8 39 --title "Success"
                else
                    whiptail --msgbox "Failed to change GID for group $modgroup. Please check for any issues." 8 39 --title "Error"
                fi
                ;;
            "3")
                # Add users to the group
                users=$(whiptail --inputbox "Enter users to add to $modgroup (comma-separated):" 8 39 --title "Add Users" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$users" ]; then
                    whiptail --msgbox "Users list cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi

                for user in $(echo "$users" | tr "," " "); do
                    if id "$user" &>/dev/null; then
                        sudo usermod -a -G "$modgroup" "$user"
                    else
                        whiptail --msgbox "User $user does not exist. Skipping..." 8 39 --title "Warning"
                    fi
                done
                whiptail --msgbox "Users $users have been added to group $modgroup." 8 39 --title "Success"
                ;;
            "4")
                # List current users in the group
                current_users=$(getent group "$modgroup" | cut -d: -f4)
                if [ -z "$current_users" ]; then
                    whiptail --msgbox "Group $modgroup has no members." 8 39 --title "Group Members"
                else
                    whiptail --msgbox "Current users in group $modgroup:\n$current_users" 20 78 --title "Group Members"
                fi
                
                # Remove users from the group
                users=$(whiptail --inputbox "Enter users to remove from $modgroup (comma-separated):" 8 39 --title "Remove Users" 3>&1 1>&2 2>&3)
                
                if [ $? != 0 ]; then
                    echo "Operation cancelled. Exiting..."
                    exit 1
                fi
                
                if [ -z "$users" ]; then
                    whiptail --msgbox "Users list cannot be empty. Please try again." 8 39 --title "Error"
                    continue
                fi

                for user in $(echo "$users" | tr "," " "); do
                    if id "$user" &>/dev/null; then
                        sudo gpasswd -d "$user" "$modgroup"
                    else
                        whiptail --msgbox "User $user does not exist. Skipping..." 8 39 --title "Warning"
                    fi
                done
                whiptail --msgbox "Users $users have been removed from group $modgroup." 8 39 --title "Success"
                ;;
            *)
                whiptail --msgbox "Invalid option selected. Please try again." 8 39 --title "Error"
                ;;
        esac
    else
        whiptail --msgbox "Group $modgroup does not exist. Please choose another group." 8 39 --title "Error"
    fi
done
