#!/bin/bash

# Script to create a local user

# Ensure the script is run as root
if [[ "${UID}" -ne 0 ]]; then
    echo -e "\e[31mError: Please run as root or use sudo.\e[0m"
    exit 1
fi

# Check if at least one argument (username) is provided
if [[ $# -lt 1 ]]; then
    echo -e "\e[33mUsage: ${0} USER_NAME [COMMENT]...\e[0m"
    echo -e "\e[33mProvide a 'USER_NAME' and optionally a 'COMMENT'.\e[0m"
    exit 1
fi

# Store user name
readonly USER_NAME="${1}"

shift
readonly COMMENT="${*}"

# Create the user
if ! useradd -c "${COMMENT}" -m "${USER_NAME}"; then
    echo -e "\e[31mError: Failed to create user '${USER_NAME}'.\e[0m"
    exit 1
fi

# Generate a random password
PASSWORD=$(date +%s%N | sha256sum | head -c12)

# Set the password for the user
echo "${USER_NAME}:${PASSWORD}" | chpasswd

if [[ $? -ne 0 ]]; then
    echo -e "\e[31mError: Failed to set password.\e[0m"
    exit 1
fi

# Force the user to change the password on first login
passwd -e "${USER_NAME}"

# Display user details
echo -e "\n\e[32mUser '${USER_NAME}' created successfully!\e[0m"
echo -e "🔹 Username: \e[34m${USER_NAME}\e[0m"
echo -e "🔹 Password: \e[31m${PASSWORD}\e[0m  \e[33m(Save this, it won't be shown again)\e[0m"
echo -e "🔹 Hostname: \e[34m$(hostname)\e[0m"

