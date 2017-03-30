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
