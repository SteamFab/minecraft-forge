# Minecraft moded server (Forge) on Google Compute Engine using Docker

Supported version: Minecraft 1.11.2

This is to setup a moded Minecraft server in Google's compute cloud. It can run on a minimal server (1 vCPU w/ 1.7 GB RAM) at a cost of less than $20 per month.

Default included mods:
  - Sponge Forge
  - VeinMiner
  - Worldedit (produced an exception)

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

<pre>
    git clone https://github.com/SteamFab/minecraft-forge.git
    ./minecraft-forge/scripts/install.sh
</pre>

7. Start the Minecraft Forge server
  ```./minecraft-forge/scripts/start.sh```

8. Debug
  - Check that the Minecraft server container is running:
    ```docker ps```
  - Look at Minecraft server logs:
    ```docker logs minecraft```
  - Execute a command inside the container:
    ```docker exec minecraft <command>```
  - If you get an error "Got permission denied while trying to connect to the Docker daemon socket." Close the terminal window and log back in. The reason for this error is that the shell needs to be restarted for the group change to take effect.
  - If something fails during the installer, then just run the installer.sh script again.

## 3. Setup backup of world to Google cloud storage

The server installation script already established a backup mechnism that runs automatically every week on Sunday. It creates a compressed archive file (.tar.gz) of your world with a date / time stamp. This backup file resides on the server's disk.
If you want the backup file to be stored more permanently in a Google cloud storage bucket, you can do the following:

1. Create a Google Cloud Storage bucket
  - Go to the Google Cloud Console, click on the upper left menu button, and chose Storage
  - Click on "Create Bucket"
  - Name: world-backup
  - Select Nearline
  - CREATE

2. Create an authenticationm key file for the storage bucket: Google uses ssh keys for you to access Google resources. So, let's create a key first:
  - Go to the Google Cloud Console, select the upper left menu button, and navigate to "API Manager"
  - Click on "Credentials" on the left
  - Click on "Create Credentials" and select "Service account key"
  - Pick "Compute Engine Default Service Account"
  - Chose "JSON" format
  - Click CREATE
  This downloads a key file. Secure this key and do NOT make it public. It gives access to your Google account.

3. Get the keyfile to the server: Now that we downloaded a keyfile in the previous step, let's get it to our instance. The easiest way is to use cut and past:
  - Open the keyfile in a text editor or open a terminal and print the keyfile in the terminal. On a Mac terminal you can use "cat keyfile.json"
  - Select the text and cut it.
  - Go to your instance terminal window and type ```nano keyfile.json```
  - Paste the content into this file and save it.
  - Make sure the keyfile.json is in the directoru minecraft-forge in your home directory.

## 4. Minecraft version

You can install a different version: Edit the Dockerfile and change the version variable.
Mods have to fit. You have to change these manually in the Dockerfile to the correct version or comment them out.

## 5. Installing more mods

Copy the mods into the mods directory using wget
Rebuild the container and update

## 6. Restore world from backup

zip or tar an existing world directory
copy the archive to the new server.
