#!/bin/bash
# Script to setup the instance server, install docker and dependencies, build the Minecraft docker container
# Tested for Ubuntu 16.04.x LTS version

# Do not run this as root but with user that has sudo permission
if [[ $EUID -eq 0 ]]; then
   echo "This script cannot be run as root" 1>&2
   exit 1
fi

# Is docker already installed?
set +e
hasDocker=$(docker version | grep "version")
set -e

if [ ! "$hasDocker" ]; then

  # Required to update system
  sudo apt-get update

  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  sudo apt-get update

  apt-cache policy docker-engine
  sudo apt-get install -y docker-engine

  # Make docker run without sudo
  #sudo systemctl status docker
  sudo usermod -aG docker $(whoami)
fi

echo "Successfully installed and configured the server"

# Build the Minecraft container
# Make group change effective by launching a new login
# You have to logout and then log back in to make it work permanently
sudo su - $USER << EOF
  cd ~/minecraft-forge
  docker build -t minecraft .
EOF

echo ""
echo "----> NOW logout or close this window and log back in. This makes your permission changes effective."
