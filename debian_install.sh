#!/usr/bin/env bash

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install --reinstall make
sudo apt-get install curl

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get install haveged
sudo DAEMON_ARGS="-w 1024"
sudo update-rc.d haveged defaults

