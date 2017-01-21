#!/bin/bash
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

  #sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
  sudo apt-get update

  apt-cache policy docker-engine
  sudo apt-get install -y docker-engine

  # Make docker run without sudo
  sudo systemctl status docker
  sudo usermod -aG docker $(whoami)
fi

# Install some additional utilities
sudo apt-get -y install wget nano cron git

# Install repository
git clone https://github.com/SteamFab/minecraft-forge.git

# Authenticate with Google cloud infrastructure
if [ -f keyfile.json ]; then
  gcloud auth activate-service-account --key-file keyfile.json
else
  echo "Missing keyfile"
  exit 1
fi

# Setup cron for backup
if [ -f backup.sh ]; then
  if ] -f backup-cron ]; then
    sudo cp backup-cron /etc/cron.d
  else
    echo "cron file missing"
    exit 1
  fi
else
  echo "backup script missing"
  exit 1
fi

echo "Successfully installed and configured the server"

# Build the Minecraft container
cd minecraft-forge
docker build -t minecraft .

docker service create -p 25565:25565 \
  --mount type=bind,source=/Users/martinsteinmann/Documents/Projects/ml/minecraft-forge/world,destination=/home/minecraft/world \
  --mount type=bind,source=/Users/martinsteinmann/Documents/Projects/ml/minecraft-forge/mods,destination=/home/minecraft/mods \
  --name minecraft minecraft

# gsutil cp xx.txt gs://world-backup
