FROM alpine:latest

# Install OpenSSH server
RUN apk add --no-cache openssh && \
    rm -rf /var/cache/apk/*

# Generate host keys
RUN ssh-keygen -A

# Set default values for username and password
ARG USERNAME=user
ARG PASSWORD=user

# Create a regular user for SSH access
RUN adduser -D $USERNAME && \
    echo "$USERNAME:$PASSWORD" | chpasswd

# Allow password authentication only (no root login)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Create a startup script
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'IP=$(ip a | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | grep -v "127.0.0.1" | head -n 1)' >> /start.sh && \
    echo 'echo "SSH server is starting. Container IP address: $IP"' >> /start.sh && \
    echo 'echo "You can now connect using ssh '"$USERNAME"'@$IP with password: '"$PASSWORD"'" >> /start.sh && \
    echo '/usr/sbin/sshd -D' >> /start.sh && \
    chmod +x /start.sh

# Set the startup script as the entry point
ENTRYPOINT ["/start.sh"]
