#!/usr/bin/env bash

CALLER_DIR=$(pwd)

cd $(dirname $0)

cat << EOF > $CALLER_DIR/.env
UID=$(id -u $USER)
GID=$(id -g $USER)
USERNAME="${USER}"
HOMEDIR="/home/${USER}"
COMPOSE_PROJECT_NAME="${PROJECTNAME}"
DOCKER_GID=$(getent group docker | cut -d: -f3)
EOF

mkdir -p ${HOME}/.aws
mkdir -p ${HOME}/.config/gh
