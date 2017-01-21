# minecraft-forge


gcloud auth login
gcloud config set project luca-153221
gcloud config set project steamfab-998

gcloud compute instances list


docker run -it -d -p 25565:25565 -e "GCLOUD_ACCOUNT=$(base64 Luca-af06bcb7b073.json )" -e "GCLOUD_ACCOUNT_EMAIL=luca-853@luca-153221.iam.gserviceaccount.com" --name mc mc


gcloud compute ssh m8giccow --zone us-east1-d


gcloud compute copy-files m8giccow:/home/minecraft/world.tar.gz .  --zone us-east1-d



Ubuntu 16:04
    1  sudo apt-get update
    2  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    3  sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
    4  sudo apt-get update
    5  apt-cache policy docker-engine
    6  sudo apt-get install -y docker-engine
    7  sudo systemctl status docker
    8  sudo usermod -aG docker $(whoami)
    9  docker --version

   13  git clone https://github.com/SteamFab/minecraft-forge.git
   15  cd minecraft-forge/

   40  nano kf.json
   41  gcloud auth activate-service-account --key-file kf.json
   42  gsutil cp xx.txt gs://world-backup


http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.11.2-13.20.0.2222/forge-1.11.2-13.20.0.2222-installer.jar
http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.11-13.19.1.2199/forge-1.11-13.19.1.2199-installer.jar
http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.10.2-12.18.3.2221/forge-1.10.2-12.18.3.2221-installer.jar
http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.10-12.18.0.2000-1.10.0/forge-1.10-12.18.0.2000-1.10.0-installer.jar
http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.9.4-12.17.0.2051/forge-1.9.4-12.17.0.2051-installer.jar
http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.9-12.16.1.1887/forge-1.9-12.16.1.1887-installer.jar

http://adfoc.us/serve/sitelinks/?id=271228&url=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.5.2-7.8.1.738/forge-1.5.2-7.8.1.738-installer.jar
