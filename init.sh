#!/bin/bash
sudo apt-get update
sudo apt-get install git
sudo git clone https://github.com/geoffreyaldebert/geocodage_ban.git

echo "Script de préparation du serveur pour le déploiement d'une instance de géocodage"

echo "Téléchargement d'un script de vérification de l'environnement"
chmod +x check-config.sh
echo "Vérification que OVERLAY FS soit bien activé : "
./check-config.sh | grep CONFIG_OVERLAY_FS

echo "Mise à jour des dépôts et installations"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common htop unzip python3

echo "Ajout du dépôt docker aux sources"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

echo "Mise à jour des dépôts et installation de docker"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install docker-compose

echo "Ajouter le service au démarrage"
sudo systemctl enable docker

echo "Ajout de l'utilisateur au groupe docker"
sudo usermod -aG docker $USER
echo "Il est nécessaire de se reconnecter pour bénéficier des privilèges"

echo "Vérification de la version de Docker"
docker version
docker info

echo "Création des répertoires pour l'instance de géocodage"
sudo mkdir -p addok/addok-data traefik

echo "Téléchargement de la dernière version des données BAN"
wget https://adresse.data.gouv.fr/data/ban/adresses-odbl/latest/addok/addok-france-bundle.zip
sudo unzip -d /addok/addok-data/ /tmp/addok-latest.zip
rm /tmp/addok-latest.zip

echo "Téléchargement du script de lancement de l'instance de géocodage"
chmod u+x ~/start.sh

echo "Redémarrage du serveur"
sudo reboot
