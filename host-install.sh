#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

# Constants
CACHE_DIR=/var/cache/pacman

# SSHd config section
SSHD_CONFIG_SECTION='\n\n# Arch package cache SFTP\nMatch Group archpkgsftp\n	ChrootDirectory /var/cache/pacman\n	ForceCommand internal-sftp\n	AllowTcpForwarding no\n	PasswordAuthentication no\n	X11Forwarding no\n\n'
printf $SSHD_CONFIG_SECTION >> /etc/ssh/sshd_config
systemctl restart sshd

# Add user and group
groupadd archpkgsftp
useradd -G archpkgsftp -d "$CACHE_DIR" archpkg

# Prepare directory
chown root "$CACHE_DIR"
chmod g+rx "$CACHE_DIR"

# Setup SSH
mkdir "$CACHE_DIR"/.ssh
touch "$CACHE_DIR"/.ssh/authorized_keys
chown -R archpkg:archpkg "$CACHE_DIR"/.ssh
chmod -R 0700 "$CACHE_DIR"/.ssh

echo "Put the SSH public key of any machine trying to connect inside of \"$CACHE_DIR/.ssh/authorized_keys\" to connect"

# Set permissions on pkg directory
chown -R archpkg:archpkgsftp "$CACHE_DIR"/pkg
chmod -R g+rw "$CACHE_DIR"/pkg
