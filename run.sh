#!/bin/sh

set -e

rsyslogd &

# Make sure world is owned by minecraft after backup restore
#chown -R $NB_USER:users $HOME/world

#start minecraft w/ user minecraft
ls -l /home/$NB_USER
cd /home/$NB_USER
cp -r mods server/
cp -r libraries server/
cp forge-$VERSION-universal.jar server/
cp minecraft_server*.jar server/
chown -R $NB_USER:users *
ls -l server
su - $NB_USER -c "cd server; java -Xms1G -Xmx7G -d64 -jar forge-$VERSION-universal.jar"
