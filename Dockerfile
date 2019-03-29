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
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2671/124/Mantle-1.12-1.3.3.42.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2640/952/Forgelin-1.8.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2580/52/tesla-core-lib-1.12.2-1.0.15.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2483/817/torohealth-1.12.2-11.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2666/521/EnderIO-1.12.2-5.0.40.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2676/458/IntegrationForegoing-1.12.2-1.9.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2683/645/%5b1.12.2%5d+SecurityCraft+v1.8.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2481/605/WailaHarvestability-mc1.12-1.1.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2666/930/Wawla-1.12.2-2.5.269.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2673/898/ModularPowersuits-1.12.2-0.7.0.035.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2499/846/davincisvessels-1.12-6.340-full.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2620/52/OpenBlocks-1.12.2-1.8.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2485/41/movingworld-1.12-2.6.342-full.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/7/OpenModsLib-1.12.2-0.12.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/256/ThermalDynamics-1.12.2-2.5.4.18-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/257/ThermalExpansion-1.12.2-5.5.3.41-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/258/ThermalFoundation-1.12.2-2.6.2.26-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2669/253/CoFHCore-1.12.2-4.6.2.25-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2487/838/Hats-1.12.2-7.0.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2650/315/Pam%27s+HarvestCraft+1.12.2zb.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/91/CoFHWorld-1.12.2-1.3.0.6-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2623/90/RedstoneFlux-1.12-2.1.0.6-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2665/717/energyconverters_1.12.2-1.2.1.11.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2664/570/industrialcraft-2-2.8.109-ex112.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2680/943/MysticalAgriculture-1.12.2-1.7.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2645/867/Cucumber-1.12.2-1.1.3.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2678/374/extrautils2-1.12-1.9.9.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2619/468/Chisel-MC1.12.2-0.2.1.35.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/667/Baubles-1.12-1.5.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2491/32/ae2stuff-0.7.0.4-mc1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2654/188/WirelessCraftingTerminal-1.12.2-3.11.88.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/31/bdlib-1.14.3.12-mc1.12.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2651/697/p455w0rdslib-1.12.2-2.0.36.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2653/753/AE2WTLib-1.12.2-1.0.6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2671/242/MysticalAgradditions-1.12.2-1.3.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2649/656/BrandonsCore-1.12.2-2.4.9.195-universal.jar

# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
