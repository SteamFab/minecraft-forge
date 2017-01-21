#docker service create -p 25565:25565 --mount type=bind,source=/Users/martinsteinmann/Documents/Projects/ml/minecraft-forge/world,destination=/home/minecraft/world --mount type=bind,source=/Users/martinsteinmann/Documents/Projects/ml/minecraft-forge/mods,destination=/home/minecraft/mods --name mc mc

# When this runs right after installing docker, then the current shell does not yet recognize the docker group membership
if id -nG $USER | grep -qw  docker; then
  docker run -rm -d -p 25565:25565  --restart=always -v ~/minecraft-forge/minecraft:/home/minecraft/server --name minecraft minecraft
else
  # Create a new shell that knows about the docker group
  sudo su - $USER << EOF
    docker run -rm -d -p 25565:25565  --restart=always -v ~/minecraft-forge/minecraft:/home/minecraft/server --name minecraft minecraft
  EOF
fi
