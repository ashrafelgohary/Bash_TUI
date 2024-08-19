# BASH-TUI: A Text-Based User Interface for Linux System Administration

**BASH-TUI** is an intuitive and interactive Text-based User Interface (TUI) designed with Whiptail to simplify the management of user accounts and groups on Linux systems. This project aims to streamline system administration by offering an easy-to-navigate interface for handling essential administrative tasks, making it accessible even for users who prefer a graphical approach within the terminal.

## Features

### User Management

- **Add User:**
  - Quickly add new users to the system with an interactive prompt.
  - Set passwords during the user creation process.
  - Prevents conflicts by checking if the username already exists.

- **Modify User:**
  - Update user details such as shell, UID, primary group, and more.
  - Features include:
    - **Update UID:** Change the User ID associated with an account.
    - **Lock/Unlock Accounts:** Instantly disable or re-enable user access.
    - **Add to Groups:** Include users in additional groups without disrupting current memberships.
    - **Change Shell:** Specify a new shell for an existing user.
  - Automatically checks if the user exists before making any modifications.

- **Delete User:**
  - Securely remove user accounts with confirmation steps to avoid unintended deletions.
  - Ensures the user exists before proceeding with the deletion.

- **List Users:**
  - Display a comprehensive list of all users currently on the system.
  - Provides a quick overview of user accounts for easier management.

### Group Management

- **Add Group:**
  - Effortlessly create new groups, ensuring the group name is unique.

- **Modify Group:**
  - Easily update group attributes, including adding or removing members.
  - Automatically verifies the existence of the group before making any changes.

- **Delete Group:**
  - Safely remove groups with clear confirmation steps to prevent accidental deletions.
  - Ensures the group exists before proceeding with deletion to avoid errors.

- **List Groups:**
  - View a complete list of all groups on the system, along with their current members.
  - Offers a clear snapshot of group configurations for streamlined management.

### Account Control

- **Disable User:**
  - Temporarily disable user accounts to prevent unauthorized access.
  - Automatically checks if the user exists before applying the lock.

- **Enable User:**
  - Restore login access by unlocking previously disabled user accounts.
  - Verifies the existence of the user before enabling the account.

- **Change Password:**
  - Securely update a user’s password through an interactive and safe process.
  - Confirms the user’s existence before allowing any password changes to ensure accuracy.

## Getting Started

### Prerequisites

Ensure you have the following installed on your system:
- **Whiptail:** A tool for displaying dialog boxes from shell scripts. Install it on Debian-based systems using:

  ```bash
  sudo apt-get install whiptail
## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/ashrafelgohary/bash-tui.git
2. **Navigate to the Directory:**

   ```bash
   cd bash-tui
3. **Run the Script:**

   ```bash
   ./main.sh

## Usage

After running the script, you'll be presented with a simple and interactive menu where you can choose the desired administrative task. Use the arrow keys to navigate through options, and select your choice by pressing Enter.

## Example Workflow

### Adding a New User

1. Select **"Add User"** from the menu.
2. Follow the prompts to enter the username, password, and other details.
3. The script will automatically check if the username already exists and notify you if there are any issues.

### Modifying a User

1. Choose **"Modify User"** from the menu.
2. Select the specific detail you want to update, such as changing the user's shell or adding them to a new group.
3. The system will validate the user’s existence before applying changes.

