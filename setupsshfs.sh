#!/bin/bash -e
#
# setupsshfs.sh - sshfs-utils
#
# Copyright (c) 2021, Francis Turner
# All rights reserved.
#
# Sets up the sshfs environment and copies the utils across
# Also check if sshfs is installed and if not apt get install sshfs
#
# SSHFS base mountpoint is /mnt/ssh/ so we create that and chmod it to
# let everyone have access. We also create .config/sshfs in the
# user directroy for current user (from $SUDO_UID or 1000 if not defined).
# If you want to use a different default then specify it on the command line
#
# Note that there is limited error checking. 
#

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

MYUID=${1:-${SUDO_UID-'1000'}}
SRC=`echo "$PWD/$0" | sed -e 's!^.*//!/!' -e 's!\(/\.\)*/[^/]*$!/!'`
HOMEDIR=`sed -n "/$MYUID:$MYUID/ s/.*$MYUID:$MYUID:[^:]*:\([^:]*\):.*/\1/p" /etc/passwd`
if ! echo $HOMEDIR | grep -q '/' 
then
	echo "Can't figure out home directory of user UID '$MYUID' Quitting" 1>&2
	exit 2
fi
if [ -d /mnt/ssh ]
then
	read -p "sshfs mountpoint already exists, are you sure you want to continue? (y/N)" ANSWER
	if [ "$ANSWER" == "${ANSWER#[Yy]}" ] ;then
		echo "Quitting" 1>&2
		exit 2
	fi
fi
echo "Creating sshfs mountpoint"
mkdir /mnt/ssh
chmod a+wx /mnt/ssh

echo "Creating config dir: ${HOMEDIR}/.config/sshfs"

sudo -u \#$MYUID mkdir ${HOMEDIR}/.config/sshfs

if ! command -v sshfs &> /dev/null
then
	echo -e 'No SSHFS found, installing\n'
	apt install sshfs
fi
echo "Copying files from $SRC to /usr/local/bin"
cd $SRC
cp *2f 2ssh /usr/local/bin

echo "Installaction complete. Do mk2f to create a mount point"
