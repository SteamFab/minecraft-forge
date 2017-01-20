# minecraft-forge


gcloud auth login
gcloud config set project luca-153221
gcloud config set project steamfab-998

gcloud compute instances list


docker run -it -d -p 25565:25565 -e "GCLOUD_ACCOUNT=$(base64 Luca-af06bcb7b073.json )" -e "GCLOUD_ACCOUNT_EMAIL=luca-853@luca-153221.iam.gserviceaccount.com" --name mc mc


gcloud compute ssh m8giccow --zone us-east1-d


gcloud compute copy-files m8giccow:/home/minecraft/world.tar.gz .  --zone us-east1-d


