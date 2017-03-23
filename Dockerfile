FROM alpine:latest

# Borrowed heavily from https://github.com/atomney/bastion
MAINTAINER Nick Jones <nick.jones@meanbee.com>

# Install required packages
RUN apk add --no-cache openssh mysql-client bash wget curl vim

# Configure the SSH server
RUN sed -i 's/\#PubkeyAuthentication\ yes/PubkeyAuthentication\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#PasswordAuthentication\ yes/PasswordAuthentication\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#PermitEmptyPasswords\ no/PermitEmptyPasswords\ no/' /etc/ssh/sshd_config && \
    sed -i 's/\#X11Forwarding\ no/X11Forwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#AllowTcpForwarding\ yes/AllowTcpForwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#AllowAgentForwarding\ yes/AllowAgentForwarding\ yes/' /etc/ssh/sshd_config && \
    sed -i 's/\#UseDNS\ no/UseDNS\ no/' /etc/ssh/sshd_config && \
    ssh-keygen -A

# Add a "bastion" user with a default password of "bastion"
RUN adduser -s /bin/bash -S bastion && \
    echo "bastion:bastion" | chpasswd && \
    mkdir -p /home/bastion/.ssh

# Set a motd
ADD etc/motd.txt /etc/motd

# Expose SSH
EXPOSE 22

# Define our entrypoint
ADD bin/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["bash", "/usr/local/bin/docker-entrypoint.sh"]

# Start the server
CMD ["/usr/sbin/sshd", "-D", "-e"]