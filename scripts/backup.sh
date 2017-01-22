#!/bin/bash
echo "Backup start"

set -e

if [ -f keyfile.json ]; then
  gcloud auth activate-service-account --key-file keyfile.json
else
  echo "keyfile.json missing"
  exit 1
fi

# source env variable MC_USER (created by backup-setup.sh)
if [ -f user ]; then
  source user
else
  echo "file 'user' missing"
  exit 1
fi

#screen -r minecraft -X stuff '/save-all\n/save-off\n'
tar czf $(date "+%Y%m%d-%H%M%S")-world.tar.gz /home/$MC_USER/minecraft-forge/minecraft/world

# Store backup in Google Storage Bucket 'world-backup'
/usr/bin/gsutil cp *-world.tar.gz  gs://world-backup

# Cleanup
rm *-world.tar.gz

#screen -r minecraft -X stuff '/save-on\n'
echo "Backup finished"
