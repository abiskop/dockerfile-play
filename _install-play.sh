#!/bin/bash

### ASSUMES apt-get update

set -e
set -u
set -x

VERSION="2.1.5"
BASE_DIR="/opt/play"
INSTALL_DIR="${BASE_DIR}/play-${VERSION}"
LATEST_DIR="${BASE_DIR}/latest"

### Download and unzip to INSTALL_DIR
mkdir -p "${INSTALL_DIR}"
wget -q -O"/tmp/play-${VERSION}.zip" "http://downloads.typesafe.com/play/${VERSION}/play-${VERSION}.zip"
apt-get -y install unzip
unzip -o -d"${BASE_DIR}" "/tmp/play-${VERSION}.zip"

ls -lah "${INSTALL_DIR}"

### Add sys user "play" and chown him INSTALL_DIR, create symlink
adduser --group --system --quiet play
chown -R play:play "${BASE_DIR}"
ls -lah "${INSTALL_DIR}"
ln -f -s "${INSTALL_DIR}" "${LATEST_DIR}"
chown -R play:play "${LATEST_DIR}"

### Make executables executable
chmod a+x ${LATEST_DIR}/play
chmod a+x ${LATEST_DIR}/framework/build
ln -f -s ${LATEST_DIR}/play /usr/bin/play

#fix PATH
export PLAY_PATH=${LATEST_DIR}
export PATH=$PATH:$PLAY_PATH
echo "export PLAY_PATH=${LATEST_DIR}" >> ~/.bashrc
echo "export PATH=$PATH:$PLAY_PATH" >> ~/.bashrc

play help
play --version
