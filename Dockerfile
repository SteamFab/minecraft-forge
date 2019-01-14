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
ENV VERSION 1.12.2-14.23.5.2768
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
RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2768/forge-1.12.2-14.23.5.2768-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2652/453/appliedenergistics2-rv6-stable-6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2657/445/TConstruct-1.12.2-2.12.0.113.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2630/860/TinkerToolLeveling-1.12.2-1.1.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2655/56/worldedit-forge-mc1.12.2-6.1.10-SNAPSHOT-dist.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2509/842/EnderStorage-1.12.2-2.4.2.126-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2638/52/ironchest-1.12.2-7.0.54.838.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2487/838/Hats-1.12.2-7.0.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2509/851/NotEnoughItems-1.12.2-2.4.1.233-universal.jar






# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
