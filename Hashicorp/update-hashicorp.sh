#!/usr/bin/env bash

INSTALL_DIR="/usr/local/bin"
BASE_URL="https://releases.hashicorp.com"

for APP in terraform consul nomad packer vault
do
  URL="${BASE_URL}/${APP}"

  VER="$(curl -sL ${URL} | grep -v beta | grep -Po "_(\d*\.?){3}" | sed 's/_//' | sort -V | tail -1)"
  echo "Updating ${APP} to ${VER}"
  ZIP="${APP}_${VER}_linux_amd64.zip"

  echo "* Downloading ${URL}/${VER}/${APP}_${VER}_linux_amd64.zip"
  curl -s ${URL}/${VER}/${APP}_${VER}_linux_amd64.zip -o /tmp/${ZIP}
  echo "* Extracting ${ZIP} into ${INSTALL_DIR}"
  sudo unzip -o /tmp/${ZIP} -d ${INSTALL_DIR} && rm -v /tmp/${ZIP}
done
