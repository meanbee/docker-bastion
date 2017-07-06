# Docker Bastion

This repository contains a container that allows us to provide temporary SSH access to an environment.  The image contains an SSH server and a MySQL client, allowing third parties to diagnose and debug problems safely in our environment.

## Usage

You could launch it as a stand alone instance on the server:

    docker run -e SSH_PASSWORD=shU3a2KnRv1n0LPNz \
        -d -P \
        --volume /example/directory/to/share:/shared/example-directory \
        --link database \
        meanbee/bastion

Or you could add it to your `docker-compose` configuration:

    bastion:
        image: meanbee/bastion
        environment:
            - SSH_PASSWORD=shU3a2KnRv1n0LPNz
        volumes:
            - /example/directory/to/share:/shared/example-directory
        links:
            - database
        expose:
            - 22

You can SSH into the container using the published port and the `bastion` user with the provided password.

## Environment variables

### SSH_PASSWORD

Required. Sets the password for the `bastion` user.

### SSH_HOME_DIR

Optional. Sets the home directory for the `bastion` user.
