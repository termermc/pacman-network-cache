# pacman-network-cache
Keep your Pacman cache on one computer to avoid unnecessary package downloads

# Purpose
These scripts setup a system that allows you to keep your Pacman package cache on a single computer, and allow other computers to share it.
This allows you to only have to download packages once, so that other computers can avoid downloading them again.

I have a desktop that is always on, and a laptop, both running Arch. When I want to update my laptop, it downloads many packages that have already been updated on my desktop. This is very wasteful, since I'm downloading several packages multiple times. This solves that problem.

# Install
First, install `sshfs`. Next, make sure you have an OpenSSH daemon running and accessible over the network.

On the host machine, run `host-install.sh` as root. This will add necessary users and configurations to make the machine a cache host.

On all client machines, you must run `client-setup.sh` as root with the host machine's address when the computer gets network access. You could probably set it up to be run when NetworkManger successfully connects to a network. You can also do it manually, the choice is yours.

If you want to switch back to a client machine's local cache, simply run `client-revert.sh` as root. This will unmount the network cache and replace it with the old local cache.

# Support
Open an issue if you have a question.