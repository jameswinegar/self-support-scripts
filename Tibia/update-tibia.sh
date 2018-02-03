#!/usr/bin/env bash

# download tibia
FILE="tibia.x64.tar.gz"
TIBIA_INSTALL_DIR="/opt/tibia"

wget http://download.tibia.com/$FILE -o /tmp/$FILE

# unzip tibia into tibia folder without version number subfolder
mkdir -p /tmp/tibia
tar -xvf $FILE -C /tmp/tibia --strip-components=1

# move tibia to TIBIA_INSTALL_DIR with desktop settings
rsync -avh --progress /tmp/tibia/. $TIBIA_INSTALL_DIR
