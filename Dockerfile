# Minecraft moded server, v1.12.2
FROM ubuntu:16.04
MAINTAINER SteamFab <martin@steamfab.io>

USER root

# install Minecraft dependencies
RUN apt-get update && apt-get install -y \
    default-jre-headless \
    wget \
    rsyslog \
    unzip \
    locales

RUN update-ca-certificates -f

# clean up
RUN apt-get clean
RUN rm -rf /tmp/* /tmp/.[!.]* /tmp/..?*  /var/lib/apt/lists/*

# Setup locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
#ENV VERSION 1.11.2-13.20.0.2222
#ENV VERSION 1.12-14.21.1.2387
#ENV VERSION 1.12.2-14.23.1.2555
ENV VERSION 1.12.2-14.23.3.2701
ENV SHELL /bin/bash
ENV NB_USER minecraft
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create minecraft user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER

# download and unpack Minecraft
WORKDIR $HOME
#RUN wget --quiet http://files.minecraftforge.net/maven/net/minecraftforge/forge/$VERSION/forge-$VERSION-installer.jar
RUN wget --quiet http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.3.2701/forge-1.12.2-14.23.3.2701-installer.jar
# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
#RUN cd mods/ && wget --quiet http://files.minecraftforge.net/maven/org/spongepowered/spongeforge/1.11.2-2201-6.0.0-BETA-2041/spongeforge-1.11.2-2201-6.0.0-BETA-2041.jar
#RUN cd mods/ && wget --quiet https://addons-origin.cursecdn.com/files/2460/570/worldedit-forge-mc1.12-6.1.8-dist.jar
#RUN cd mods/ && wget --quiet https://addons-origin.cursecdn.com/files/2456/533/VeinMiner-1.12-0.38.0.633+f768836.jar
RUN mkdir mods
RUN cd mods/ && wget  https://addons.cursecdn.com/files/2454/983/appliedenergistics2-rv4-stable-1.jar
RUN cd mods/ && wget  https://addons.cursecdn.com/files/2425/769/BiomesOPlenty-1.10.2-5.0.0.2236-universal.jar
RUN cd mods/ && wget  https://media.forgecdn.net/files/2425/847/ironchest-1.10.2-7.0.15.804.jar
RUN cd mods/ && wget  https://media.forgecdn.net/files/2518/860/JurassiCraft-2.1.3-Fix.jar
RUN cd mods/ && wget  https://media.forgecdn.net/files/2425/964/TConstruct-1.10.2-2.6.5.jar
RUN cd mods/ && wget  https://media.forgecdn.net/files/2498/641/MineFactoryReloaded-%5b1.10.2%5d2.9.0B1-230.jar
# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
