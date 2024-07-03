sudo apt-get update; 
sudo apt-get upgrade -y;
curl -sSL https://get.docker.com | sh;
sudo usermod -aG docker javi;
sudo apt-get install docker-compose -y;