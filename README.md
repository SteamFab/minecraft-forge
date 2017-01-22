# Minecraft moded server (Forge) on Google Compute Engine using Docker

Supported version: Minecraft 1.11.2

This is to setup a moded Minecraft server in Google's compute cloud. It can run on a minimal server (1 vCPU w/ 1.7 GB RAM) at a cost of less than $20 per month.

Default included mods:
  - Sponge Forge 1.11.2-2201
  - VeinMiner 1.11-0.35.3.605 
  - Worldedit 1.11-6.1.6

To change or update the default mods you can change the Dockerfile.

## Prerequsites
- Google Compute Engine account
- Some knowledge of Linux commands

## Quick start
If you are an expert, here are the steps:
  - Create an instance on Google Compute Cloud running Ubuntu 16.04 LTS
  - Create a Google firewall rule to open port tcp:25565
  - Clone this github repo and run the installer install.sh
  - Run the start script start.sh
  - Run the Minecraft client and log into your new server using the IP address of the instance
  - To enable backups run backup-setup.sh (setup a Google storage bucket called world-backup first)
This quick start procedure creates a new moded server with our default mods. It does not setup backups and you have not yet restored an existing world into the new server. Continue reading if that is what you want to do.

## Detailed installation steps

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
  - Click on SSH on the right
  - A terminal window should open with a command prompt (black screen)
  - Type the following commands:

<pre>
    git clone https://github.com/SteamFab/minecraft-forge.git
    ./minecraft-forge/scripts/install.sh
</pre>
  - Some errors (red text) are normal during the Minecraft server installation. Make sure the script completes successfully. It says so at the end. If not re-run the install.sh script. Sometimes the Minecraft download server seems to time out.

7. Start the Minecraft Forge server

<pre>./minecraft-forge/scripts/start.sh</pre>

8. Debug - in case of trouble
  - Check that the Minecraft server container is running: ```docker ps```
  - Look at Minecraft server logs: ```docker logs minecraft```
  - Execute a command inside the container: ```docker exec minecraft <command>```
  - If you get an error "Got permission denied while trying to connect to the Docker daemon socket." Close the terminal window and log back in. The reason for this error is that the shell needs to be restarted for the group change to take effect.
  - If something fails during the installer, then just run the installer.sh script again.

## Setup backup of world to Google cloud storage

To established a backup mechnism that runs automatically every week on Sunday, create a file keyfile.json and run the script backup-setup.sh. It creates a compressed archive file (.tar.gz) of your world with a date / time stamp. This backup file resides on the server's disk.
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
  - Go to your instance terminal window and type ```nano ~/minecraft-forge/keyfile.json```
  - Paste the content into this file and save it.
  - Make sure the keyfile.json is in the directoru minecraft-forge in your home directory.
  - Now you need to run the backup-setup.sh  script to activate the Google account.
<pre>
    ./scripts/backup-setup.sh
</pre>
4. Debug backups
  - Backups only run once a week on Sunday. To check: ```sudo cat /var/log/cron.log```
  - The cron file is here: /etc/cron.d/backup-cron
  - The backup script is here /root/backup.sh

## Restarting Minecraft: Restarting Minecraft means re-starting the Docker container it runs inside of:
<pre>
  docker stop minecraft
  docker rm minecraft
  ./scripts/start.sh
</pre>
Check that it runs:
<pre>
  docker ps
  docker logs minecraft
</pre>

## Minecraft version

You can install a different Minecraft version: Edit the Dockerfile and change the version variable.
The Mods have to fit the Minecraft version. You have to change these manually in the Dockerfile to the correct version or comment them out.

## Installing more mods: Copy the mods into the minecraft-forge/minecraft/mods directory using wget on your instance:
After you cloned this repo there will be a mods directory in minecraft/mods. This is where additional mods go. The easiest is to directly download them from a Web site using the wget command.
<pre>
  cd ~/minecraft-forge/minecraft/mods
  wget URL of your mod
</pre>
  - Rebuild the container: Re-run the install.sh script.
    Alternatively you can just run the docker build command: ```docker build -t minecraft .```
  - Restart Minecraft as described above.

## Restore world from backup
The server's world directory is in minecraft-forge/minecraft/world on your instance. To restore a backup you have to copy your existing world directory into this location. Before you delete the existing world directory you can copy it elsewhere or do a backup. 

  - zip or tar an existing world directory to create a single archive file. This can be on an existing server, a realm, or your local laptop / desktop computer.
  - Copy the archive to the new instance. This can be a little tricky. The easiest is to use Google's gcloud utility tool.
    - Install gcloud on your computer: https://cloud.google.com/sdk/downloads
    - Login to google: <pre>gcloud auth login</pre>
    - A browser window opens. Login to your Google account and grant permission to gcloud.
    - Now you can use gcloud to copy your world archive file to your instance:
<pre>
  gcloud compute instances list
  gcloud compute copy-files your-archive-file your-instance-name:.
</pre>
    - Log back into your instance by opening a terminal window
    - Find the uploaded file: It is likely under a different account. Do this:
<pre>
  ls -l /home
</pre>
    - You see all the different account's home directories now. Use <pre>ls -l /home/dir-name</pre> to list content of the different home directories to find the file you just uploaded.
    - Once found move it to the minecraft-server/minecraft directory using the mv command. Make sure you stop the Minecraft server container before doing this.
    - Inflate or unzip the file. You might have to remove an already existing world directory before you do this.
    - You should now have your world in the directory minecraft/world
    - Now restart the Minecraft container
