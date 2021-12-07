#!/bin/bash
if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

DIR=/var/cache/pacman/pkg
OLD="$DIR.old"

if [ ! -d "$OLD" ]; then
	echo "There is no old pkg directory to restore"
	exit 1
fi

fusermount -u "$DIR"

rm -r "$DIR"
mv "$OLD" "$DIR"
