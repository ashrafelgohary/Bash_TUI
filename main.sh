#!/bin/bash
CHOICE=$(
        whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
        "<-- Back" "Return to the main menu." \
        "Add User" "Add a user to the system." \
        "Modify User" "Modify an existing user." \
        "Delete User" "Delete an existing user." \
        "List Users" "List all users on the system." \
        "Add Group" "Add a user group to the system." \
        "Modify Group" "Modify a group and its list of members." \
        "Delete Group" "Delete an existing group." \
        "List Groups" "List all groups on the system." \
        "Disable User" "Lock the user account." \
        "Enable User" "Unlock the user account." \
        "Change Password" "Change the password of a user." \
        3>&2 2>&1 1>&3
    )

    case $CHOICE in
        "<-- Back")
            echo "Returning to the main menu..."
            ;;
        "Add User")
                ./adduser.sh
            ;;
        "Modify User")
                ./modifyuser.sh
            ;;
        "Delete User")
                ./deleteuser.sh
            ;;
        "List Users")
                ./listusers.sh
            ;;
        "Add Group")
                ./addgroup.sh
            ;;
        "Modify Group")
                ./modifygp.sh
            ;;
        "Delete Group")
                ./deletegroup.sh
            ;;
        "List Groups")
                ./listgroups.sh
            ;;
        "Disable User")
                ./disableuser.sh
            ;;
        "Enable User")
                ./enableuser.sh
            ;;
        "Change Password")
                ./chg-pass.sh
            ;;
        *)
            whiptail --msgbox "Invalid option. Please select again." 8 39 --title "Error"
            ;;
    esac
