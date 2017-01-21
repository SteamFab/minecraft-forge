#!/bin/bash
echo "Backup start"
source /root/.cronrc

#screen -r minecraft -X stuff '/save-all\n/save-off\n'
tar czf $(date "+%Y%m%d-%H%M%S")-world.tar.gz /home/minecraft/world

/opt/google-cloud-sdk/bin/gsutil cp *-world.tar.gz  gs://world-backup
rm *-world.tar.gz

#screen -r minecraft -X stuff '/save-on\n'
echo "Backup finished"
