#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Group name
GROUP="devteam"

USERS=("devuser1" "devuser2" "devuser3" "devuser4" "devuser5")

DEFAULT_PASSWORD="ChangeMe123!"

if ! getent group "$GROUP" > /dev/null; then
    echo "Creating group: $GROUP"
    groupadd "$GROUP"
else
    echo "Group $GROUP already exists."
fi


for USER in "${USERS[@]}"; do
    if id "$USER" &>/dev/null; then
        echo "User $USER already exists. Skipping."
    else
        echo "Creating user: $USER"
        useradd -m -s /bin/bash -G "$GROUP" "$USER"
        echo "$USER:$DEFAULT_PASSWORD" | chpasswd
        chage -d 0 "$USER"   
        echo "User $USER created and added to group $GROUP."
    fi
done

echo "All users have been created and configured."
