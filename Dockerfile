FROM ubuntu:20.04

ENV PS4DEV=/usr/local/ps4dev

RUN echo 'alias build="make clean && make"' >> ~/.bashrc
RUN echo 'export OO_PS4_TOOLCHAIN=${PS4DEV}/ps4toolchain' >> ~/.bashrc

#Get deps
RUN \
    apt-get -y update && \
    apt-get -y install wget nano build-essential llvm clang lld curl git && \
    apt-get -y clean autoclean autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

#Download latest release
RUN \
    mkdir -p ${PS4DEV} && \
    cd ${PS4DEV} && \
    LATEST=$(curl -sL --fail https://api.github.com/repos/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/latest | grep "tag_name" | perl -pe 'if(($_)=/([0-9]+([.][0-9]+)+)/){$_.="\n"}') ; curl -vsL "https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/download/v$LATEST/v$LATEST.tar.gz" -O

#Unpack toolchain and setup
RUN \
    cd ${PS4DEV} && \
    mkdir -p ${PS4DEV}/ps4toolchain && \
    mv *.tar.gz ps4toolchain && \
    cd ps4toolchain && \
    tar -xvzf *.tar.gz && \
    rm *.tar.gz

CMD /bin/bash

RUN echo '[ ! -z "$PS4SDKWORKDIR" ] && cd ${PS4SDKWORKDIR} || echo "PS4SDKWORKDIR is not set!"' >> ~/.bashrc
