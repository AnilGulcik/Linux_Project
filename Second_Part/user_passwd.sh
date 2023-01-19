#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
    echo "Please run this script as root or with superuser privileges."
    exit 1
fi

# Get the username (login).
read -p "Enter your username: " USERNAME

# Get the real name (contents for the description field).
read -p "Enter your comment: " COMMENT

# Get the password.
read -sp "Enter your password: " PASSWORD

# Create the account.
useradd -c ${COMMENT} -m ${USERNAME}
# Check to see if the useradd command succeeded.

# We don't want to tell the user that an account was created when it hasn't been.
if [[ ${?} -ne 0 ]]
then
    echo -e "\nThis username is already exists. Please select a different user name."
    exit
fi 
# Set the password.
passwd -e ${USERNAME}
# Check to see if the passwd command succeeded.
if [[ ${?} -ne 0 ]]
then
    echo -e "\nThe password or the account could not be set."
    exit
fi 


# Display the username, password, and the host where the user was created.
 echo
 echo -e "Username is ${USERNAME}\n"
 echo -e "Your password is ${PASSWORD}\n"
