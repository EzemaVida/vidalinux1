#!/bin/bash

# Create the shared directory
mkdir -p /shared_data

# Set the group ownership (assuming 'sharedgroup' exists)
chgrp sharedgroup /shared_data

# Set directory permissions: group read/write/execute, sticky bit to prevent deletion of others' files
chmod 2770 /shared_data

# Enable ACL on the filesystem (if not already enabled)
# Note: Filesystem must support ACLs, and acl package must be installed
setfacl -m g:sharedgroup:rwX /shared_data
setfacl -m d:g:sharedgroup:rwX /shared_data

# Grant read-only access to an extra user (e.g., 'readonlyuser')
setfacl -m u:readonlyuser:rX /shared_data
setfacl -m d:u:readonlyuser:rX /shared_data

# Verify the permissions
getfacl /shared_data