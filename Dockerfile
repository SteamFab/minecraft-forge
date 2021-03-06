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
ENV VERSION 1.12.2-14.23.5.2837
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
RUN wget --quiet https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2837/forge-1.12.2-14.23.5.2837-installer.jar

# run Minecraft installer
RUN java -jar forge-$VERSION-installer.jar --installServer
RUN rm forge-$VERSION-installer.jar

# Install some mods
RUN mkdir mods
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2496/769/JRFTL%5b1.12.2%5d-1.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2524/58/ChestTransporter-1.12.2-2.8.8.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2652/182/Advanced+Solar+Panels-4.3.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2690/877/refinedstorage-1.6.14.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2690/723/refinedstorageaddons-0.4.4.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2719/436/jei_1.12.2-4.15.0.280.jar 
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/31/bdlib-1.14.3.12-mc1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2716/138/ThermalDynamics-1.12.2-2.5.5.21-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2717/443/Pam%27s+HarvestCraft+1.12.2zd+Surprise+for+Yogcast.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2618/630/CodeChickenLib-1.12.2-3.2.2.353-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/253/CoFHCore-1.12.2-4.6.2.25-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/91/CoFHWorld-1.12.2-1.3.0.6-universal.jar
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
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2715/789/ThermalExpansion-1.12.2-5.5.4.43-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/90/RedstoneFlux-1.12-2.1.0.6-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2642/386/StorageDrawers-1.12.2-5.3.8.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/258/ThermalFoundation-1.12.2-2.6.2.26-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2693/496/TConstruct-1.12.2-2.12.0.135.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2630/860/TinkerToolLeveling-1.12.2-1.1.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2696/150/CookingForBlockheads_1.12.2-6.4.70.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2693/483/Mantle-1.12-1.3.3.49.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2619/468/Chisel-MC1.12.2-0.2.1.35.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2642/375/CTM-MC1.12.2-0.3.3.22.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2574/880/BiblioCraft%5bv2.4.5%5d%5bMC1.12.2%5d.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2654/304/bonsaitrees-1.1.2-b144.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2670/493/ironchest-1.12.2-7.0.59.842.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2568/464/Streams-1.12-0.4.4.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2699/878/industrialforegoing-1.12.2-1.12.12-236.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2676/458/IntegrationForegoing-1.12.2-1.9.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2564/573/IronBackpacks-1.12.2-3.0.8-12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2561/617/secretroomsmod-1.12.2-5.6.4.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2722/271/ExtremeReactors-1.12.2-0.4.5.67.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2453/251/MusicCraft-3.2.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2644/653/BiomesOPlenty-1.12.2-7.0.1.2419-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2492/586/RoguelikeDungeons-1.12.2-1.8.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2707/388/rftools-1.12-7.71.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2618/264/twilightforest-1.12.2-3.8.689-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/667/Baubles-1.12-1.5.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2685/412/llibrary-1.7.18-1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2583/91/Farseek-1.12-2.3.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2670/570/zerocore-1.12.2-0.1.2.8.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2580/52/tesla-core-lib-1.12.2-1.0.15.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2714/365/mcjtylib-1.12-3.5.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2450/900/Chameleon-1.12-4.1.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2640/952/Forgelin-1.8.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2609/648/AgriCraft-2.12.0-1.12.0-a6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2622/466/magicalcrops-1.0.2-MC-1.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2537/265/infinitylib-1.12.0.jar

# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
