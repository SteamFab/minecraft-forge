# Minecraft moded server (Forge) on Google Compute Engine using Docker

Supported version: Minecraft 1.11.2

This is to setup a moded Minecraft server in Google's compute cloud. It can run on a minimal server (1 vCPU w/ 1.7 GB RAM) at a cost of less than $20 per month.

## 1. Prerequsites
- Google Compute Engine account

## 2. Installation steps

1. If you don't already have one, create a Google compute engine account (https://cloud.google.com/compute/). You need a credit card for this.
2. Go to the Google Compute Engine console (https://console.cloud.google.com/compute)
3. Create a new instance
  - Name: minecraft
  - Zone: chose one
  - Machine type: Small one shared vCPU / 1.7 GB RAM (minimum machine)
  - Boot disk: Ubuntu 16.04 LTS, Boot disk type: SSD persistent disk, Size: 10 GB min, SELECT
  - Identity and API access: Default
  - Firewall: none
  - CREATE

4. Create the firewall rule:
  - Click upper left menu, go to Networking (in the section compute)
  - Click on Firewall rules on the left
  - Create new firewall ruls (top)
  - Chose the following:
    - Name: minecraft-rule
    - Network: default
    - Source filter: Allow from any source (0.0.0.0)
    - Allow protocols and ports: tcp:25565
    - Target tags: minecraft-server
    - CREATE

5. Assign firewall rule to instance
  - Go back to the Compute Engine console where you can see your instance
  - Click on the instance
  - Click EDIT at the top
  - Scroll down to the line that says TAGS
  - Enter a new tag: minecraft-server
  - Scroll down and SAVE

6. Install the server
  - Go to Compute Cloud console where you can see your instance
  - lick on SSH on the right
  - A terminal window should open with a command prompt (black screen)
  - Type the following commands:

```
    git clone https://github.com/SteamFab/minecraft-forge.git
    ./minecraft-forge/scripts/install.sh
```

7. Start the Minecraft Forge server
  ```./minecraft-forge/scripts/start.sh```

8. Debug
  - Check that the Minecraft server container is running:
    ```docker ps```
  - Look at Minecraft server logs:
    ```docker logs minecraft```
  - Execute a command inside the container:
    ```docker exec minecraft <command>```

## 3. Setup backup of world to Google cloud storage

The server installation script already established a backup mechnism that runs automatically every week on Sunday. It creates a compressed archive file (.tar.gz) of your world with a date / time stamp. This backup file resides on the server's disk.
If you want the backup file to be stored more permanently in a Google cloud storage bucket, you can do the following:

1. Create a Google Cloud Storage bucket

2. Create an authenticationm key file for the storage bucket

3. Get the keyfile to the server

## 4. Minecraft version

You can install a different version: Edit the Dockerfile and change the version variable.
Mods have to fit

## 5. Installing more mods

Copy the mods into the mods directory using wget
Rebuild the container and update


