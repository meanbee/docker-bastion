#!/bin/bash

# Don't allow the setup to proceed unless there's an SSH password defined
[ -z "${SSH_PASSWORD}" ] && \
    echo "[ERROR] Yeah, I'm gonna need you to define an \$SSH_PASSWORD before I let you continue." && exit 1

# Change the SSH user's password to the environment variable
echo "bastion:${SSH_PASSWORD}" | chpasswd

# Change bastion's home directory if specified
[ -n "${SSH_HOME_DIR}" ] && \
    usermod -d $SSH_HOME_DIR bastion

exec "$@"
