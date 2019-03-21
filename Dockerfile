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
RUN wget --quiet RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2768/forge-1.12.2-14.23.5.2768-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2682/821/Morph-1.12.2-7.1.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2664/449/Morpheus-1.12.2-3.5.106.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2630/860/TinkerToolLeveling-1.12.2-1.1.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2662/253/TConstruct-1.12.2-2.12.0.115.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/243/EnderStorage-1.12.2-2.4.5.135-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2652/453/appliedenergistics2-rv6-stable-6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2618/630/CodeChickenLib-1.12.2-3.2.2.353-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2664/60/EnderCore-1.12.2-0.5.45.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2568/751/Hwyla-1.8.26-B41_1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2684/0/iChunUtil-1.12.2-7.2.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2687/546/industrialforegoing-1.12.2-1.12.8-232.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2682/936/jei_1.12.2-4.15.0.268.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2622/466/magicalcrops-1.0.2-MC-1.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2671/124/Mantle-1.12-1.3.3.42.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2640/952/Forgelin-1.8.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2580/52/tesla-core-lib-1.12.2-1.0.15.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2483/817/torohealth-1.12.2-11.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2666/521/EnderIO-1.12.2-5.0.40.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2676/458/IntegrationForegoing-1.12.2-1.9.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2683/645/%5b1.12.2%5d+SecurityCraft+v1.8.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2481/605/WailaHarvestability-mc1.12-1.1.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2666/930/Wawla-1.12.2-2.5.269.jar

# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
