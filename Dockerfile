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
ENV VERSION 1.12.2-14.23.4.2746
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
RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.4.2746/forge-1.12.2-14.23.4.2746-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2486/444/Hats-1.12.2-7.0.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2571/785/TConstruct-1.12.2-2.10.1.87.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2609/899/conarm-1.12.2-1.1.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2570/118/TinkerToolLeveling-1.12.2-1.0.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2611/991/extrautils2-1.12-1.9.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2550/550/Mantle-1.12-1.3.2.24.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2510/760/iChunUtil-1.12.2-7.1.4.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2496/769/JRFTL%5b1.12.2%5d-1.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2530/225/OpenBlocks-1.12.2-1.7.6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2525/230/OpenModsLib-1.12.2-0.11.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/667/Baubles-1.12-1.5.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/241/ChickenChunks-1.12.2-2.4.1.73-universal.jar



# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
