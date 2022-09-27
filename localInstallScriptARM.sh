#!/bin/bash
echo "Run this script to begin the install process LOCALLY for TAK Server, it will take a while so please be patient."
read -p "Press any key to begin ..."

#Create TAK user
adduser tak
usermod -aG sudo tak

#Update apt
sudo apt-get update -y

#Install Deps
sudo apt-get install unzip wget git nano openssl net-tools -y

#Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce
echo "*** DOCKER INSTALLED ***"

#Install Docker-Compose
cd /tmp
sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "*** DOCKER COMPOSE INSTALLED ***"
docker-compose --version

#Start docker, run at system startup
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker tak

echo " "
echo "Cloning CloudRF Github Docker Install Project..."
cd /home/tak/
git clone https://github.com/Cloud-RF/tak-server.git

echo " "
echo "Done, updating script permissions"
sudo chown -R tak:tak /home/tak/*
sudo chmod +x ~/tak-server/scripts/setup.sh

#Install TAK Server
cd /home/tak/tak-server
echo " "
echo "*****************************************************************************"
echo "Please move your tak server zip file into $(pwd)"
echo " "
echo "Then login as tak superuser with:"
echo "su - tak"
echo " "
echo "Once Logged in, enter the following command to being the docker install script:"
echo "cd tak-server && ./scripts/setup.sh"
echo " "
echo "*******************************************************************************"
