# Procédure d'installation :

```
sudo apt-get update
sudo apt-get install git
git clone https://github.com/geoffreyaldebert/geocodage_ban.git
cd geocodage_ban
chmod +x init.sh
sudo ./init.sh
```

# Précédure de lancement :

```
cd geocodage_ban
chmod +x start.sh
sudo docker network create traefik
sudo ./start.sh 4 4 # First, nb redis, second nb front"
```
