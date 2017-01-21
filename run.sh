#!/bin/sh

set -e

rsyslogd &

# Make sure world is owned by minecraft after backup restore
#chown -R $NB_USER:users $HOME/world

#start minecraft w/ user minecraft
ls -l /home/$NB_USER
cd /home/$NB_USER/server
cp ../forge-$VERSION-universal.jar .
su - $NB_USER -c "java -Xms1G -Xmx7G -d64 -jar forge-$VERSION-universal.jar"
