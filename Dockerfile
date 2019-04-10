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
ENV VERSION 1.12.2-14.23.5.2810
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
RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2810/forge-1.12.2-14.23.5.2810-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://ore.spongepowered.org/Nucleus/Nucleus/versions/recommended/download
RUN cd mods/ && wget --quiet https://repo.spongepowered.org/maven/org/spongepowered/spongeforge/1.12.2-2768-7.1.5/spongeforge-1.12.2-2768-7.1.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2652/182/Advanced+Solar+Panels-4.3.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2491/32/ae2stuff-0.7.0.4-mc1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2652/453/appliedenergistics2-rv6-stable-6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2682/722/astikorcarts-1.12.2-0.1.2.6.jar 
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/31/bdlib-1.14.3.12-mc1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2473/983/chococraft_1.12.1-0.9.1.52.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2618/630/CodeChickenLib-1.12.2-3.2.2.353-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/253/CoFHCore-1.12.2-4.6.2.25-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2513/671/CoFHWorld-1.12.2-1.1.1.12-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2692/118/EnderIO-1.12.2-5.0.43.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/243/EnderStorage-1.12.2-2.4.5.135-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2696/287/EnderCore-1.12.2-0.5.53.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2678/374/extrautils2-1.12-1.9.9.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2487/838/Hats-1.12.2-7.0.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2684/0/iChunUtil-1.12.2-7.2.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2664/570/industrialcraft-2-2.8.109-ex112.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2664/449/Morpheus-1.12.2-3.5.106.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2620/52/OpenBlocks-1.12.2-1.8.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/7/OpenModsLib-1.12.2-0.12.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2696/248/Pam%27s+HarvestCraft+1.12.2zc+The+7mm+Kidney+Stone+Update.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/90/RedstoneFlux-1.12-2.1.0.6-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2697/143/TeaStory-3.3.1-B29.409-1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/258/ThermalFoundation-1.12.2-2.6.2.26-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2693/496/TConstruct-1.12.2-2.12.0.135.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2630/860/TinkerToolLeveling-1.12.2-1.1.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2696/150/CookingForBlockheads_1.12.2-6.4.70.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2693/483/Mantle-1.12-1.3.3.49.jar


# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
