#!/bin/bash
# Script to setup backups, local cron job, auth with Google Storage, copy backup to Google storage bucket
# Tested for Ubuntu 16.04.x LTS version

set -e

# Do not run this as root but with user that has sudo permission
if [[ $EUID -eq 0 ]]; then
   echo "This script cannot be run as root" 1>&2
   exit 1
fi

# Setup cron for backup
cd ~/minecraft-forge/scripts
if [ -f backup.sh ]; then
  if [ -f backup-cron ]; then
    sudo cp backup-cron /etc/cron.d
    sudo cp backup.sh /root
    echo 'export MC_USER='$USER > ~/user
    sudo cp ~/user /root
  else
    echo "cron file missing"
    exit 1
  fi
else
  echo "backup script missing"
  exit 1
fi

# Authenticate with Google cloud infrastructure
cd ~/minecraft-forge
if [ -f keyfile.json ]; then
  gcloud auth activate-service-account --key-file keyfile.json
  sudo cp keyfile.json /root
else
  echo "Missing keyfile. Backup only on local host."
  exit 1
fi

echo ""
echo "Successfully configured backup"
