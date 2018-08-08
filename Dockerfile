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
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2589/23/BloodMagic-1.12.2-2.3.1-99.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2486/444/Hats-1.12.2-7.0.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2597/220/extrautils2-1.12-1.8.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2543/840/appliedenergistics2-rv5-stable-11.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2499/846/davincisvessels-1.12-6.340-full.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2560/919/Pam%27s+HarvestCraft+1.12.2u.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2483/852/MCA-1.12.x-5.3.1-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2567/265/ThermalExpansion-1.12.2-5.5.0.29-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2567/555/ThermalFoundation-1.12.2-2.5.0.19-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2569/8/ThermalDynamics-1.12.2-2.5.1.14-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2567/269/ThermalInnovation-1.12.2-0.3.0.7-universal.jar
RUN cd mods/ && wget --quiet https://maven.tterrag.com/index.php?dir=com%2Fenderio%2Fcore%2FEnderCore%2F1.12.2-0.5.36%2FEnderCore-1.12.2-0.5.36.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2570/118/TinkerToolLeveling-1.12.2-1.0.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2570/118/TinkerToolLeveling-1.12.2-1.0.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2597/800/EnderIO-1.12.2-5.0.31.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/711/Draconic-Evolution-1.12.2-2.3.13.306-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2581/238/UniDict-1.12.2-2.5f.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2530/225/OpenBlocks-1.12.2-1.7.6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2572/881/Mekanism-1.12.2-9.4.13.349.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2496/769/JRFTL%5b1.12.2%5d-1.1.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2557/247/ProjectE-1.12-PE1.3.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/241/ChickenChunks-1.12.2-2.4.1.73-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2590/485/industrialforegoing-1.12.2-1.10.7-204.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2518/667/Baubles-1.12-1.5.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2445/532/Tails-1.12-1.10.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2477/77/TrashSlot_1.12.1-8.4.6.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2526/674/malisisdoors-1.12.2-7.3.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2502/741/buildcraft-7.99.12.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2594/243/EnderStorage-1.12.2-2.4.5.135-universal.jar
RUN cd mods/ && wget --quiet https://ci.micdoodle8.com/job/Galacticraft-1.12/181/artifact/Forge/build/libs/Galacticraft-Planets-1.12.2-4.0.1.181.jar
RUN cd mods/ && wget --quiet https://ci.micdoodle8.com/job/Galacticraft-1.12/181/artifact/Forge/build/libs/GalacticraftCore-1.12.2-4.0.1.181.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2597/168/CodeChickenLib-1.12.2-3.2.1.350-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2597/417/industrialcraft-2-2.8.96-ex112.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2595/146/ironchest-1.12.2-7.0.46.831.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2591/543/jei_1.12.2-4.11.0.206.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2550/550/Mantle-1.12-1.3.2.24.jar
RUN cd mods/ && wget --quiet http://ci.micdoodle8.com/job/Galacticraft-1.12/181/artifact/Forge/build/libs/MicdoodleCore-1.12.2-4.0.1.181.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2571/785/TConstruct-1.12.2-2.10.1.87.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2528/295/VeinMiner-1.12-0.38.2.647%2Bb31535a.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2583/886/Guide-API-1.12-2.1.6-61.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2485/41/movingworld-1.12-6.342-full.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2593/747/BrandonsCore-1.12.2-2.4.4.173-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2487/842/iChunUtil-1.12.2-7.0.2.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2580/52/tesla-core-lib-1.12.2-1.0.15.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2508/318/malisiscore-1.12.2-6.3.0.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2483/855/RadixCore-1.12.x-2.2.1-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2525/230/OpenModsLib-1.12.2-0.11.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2586/247/CoFHCore-1.12.2-4.5.3.20-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2567/263/CoFHWorld-1.12.2-1.2.0.5-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2534/271/WanionLib-1.12.2-1.5.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2567/260/RedstoneFlux-1.12-2.0.2.3-universal.jar
RUN cd mods/ && wget --quiet https://media.forgecdn.net/files/2573/311/Forgelin-1.7.4.jar

# Configure remaining tasks for root user
USER root
WORKDIR /root

# Run Minecraft
EXPOSE 25565

COPY run.sh .

ENTRYPOINT ["/root/run.sh"]
