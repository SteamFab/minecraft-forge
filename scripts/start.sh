#!/bin/bash
# Start script to run or restart the Minecraft container

# Test if docker can be executed as non-root
if id -nG $USER | grep -qw  docker; then

  set +e

  app='minecraft'

  if [ "$(docker ps -q -f name=$app)" ]; then
    echo "Stopping and removing running Minecraft container"
    docker stop $app && docker rm -f $app
  fi

  if [ "$(docker ps -aq -f status=exited -f name=$app)" ]; then
    echo "Removing old Minecraft container"
    docker rm -f $app
  fi

  set -e

  # Start new Minecraft container
  docker run -it -d -p 25565:25565  --restart=always -v /home/$USER/minecraft-forge/minecraft:/home/minecraft/server --name minecraft minecraft

else
  echo "---> Failed to launch the Minecraft container:"
  echo "Close this window and shell and log back in. Your docker group membership has not yet taken effect after running install.sh"
fi
