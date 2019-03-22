#!/bin/sh

set -e

rsyslogd &

# Make sure world is owned by minecraft after backup restore
#chown -R $NB_USER:users $HOME/world

# Copy files to the shared volume where we will run Minecraft
cd /home/$NB_USER
cp -r mods server/           # copy mods that were installed via Dockerfile
cp -r libraries server/
cp forge-$VERSION-universal.jar server/
cp minecraft_server*.jar server/
chown -R $NB_USER:users *

#start minecraft w/ user minecraft
su - $NB_USER -c "cd server; java -Xms1G -Xmx7G -d64 -jar forge-$VERSION-universal.jar"
