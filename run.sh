#!/bin/sh

set -e

if [ -n "${GCLOUD_ACCOUNT}" ]; then
  echo ${GCLOUD_ACCOUNT} >> /opt/gcloud/auth.base64
  base64 -d /opt/gcloud/auth.base64 >> /opt/gcloud/auth.json
  which base64
  echo "${GCLOUD_ACCOUNT_EMAIL}"
  gcloud auth activate-service-account --key-file=/opt/gcloud/auth.json ${GCLOUD_ACCOUNT_EMAIL}
fi

#if [ -n "${GCLOUD_ACCOUNT_FILE}" ]; then
#  gcloud auth activate-service-account --key-file=${GCLOUD_ACCOUNT_FILE} ${GCLOUD_ACCOUNT_EMAIL}

# save environment for cron backup job
env > /root/.cronrc

rsyslogd &
cron
chown -R $NB_USER:users /home/$NB_USER/world

#start minecraft w/ user minecraft
su - $NB_USER -c "java -Xms1G -Xmx7G -d64 -jar forge-1.11.2-13.20.0.2222-universal.jar"
#login -f $NB_USER screen -S minecraft java -Xms1G -Xmx7G -d64 -jar forge-1.11.2-13.20.0.2222-universal.jar nogui

#script -q  "su $NB_USER -l -c \"screen -m -d -S minecraft java -Xms1G -Xmx7G -d64 -jar forge-1.11.2-13.20.0.2222-universal.jar nogui  \"" /dev/null 

#sleep 5
#minecraft_pid=$(ps aux | grep -i screen | awk {'print $2'})

#echo "Minecraft PID $minecraft_pid"

#sleep 220
#su - $NB_USER -c "./backup.sh"

#wait $minecraft_pid
