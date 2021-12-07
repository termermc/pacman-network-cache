#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

HOST=$1
DIR=/var/cache/pacman/pkg
OLD="$DIR.old"

if [ ! -n "$HOST" ]; then
	echo "Please specify the host to connect to"
	exit 1
fi

echo "Remember to add your root account's id_rsa.pub file contents to the authorized_keys file on the host!"

if [ ! -d "$OLD" ]; then
	mv "$DIR" "$OLD"
fi
if [ ! -d "$DIR" ]; then
	mkdir "$DIR"
	chmod a+r "$DIR"
fi

sshfs archpkg@"$HOST":/pkg "$DIR" -o reconnect
