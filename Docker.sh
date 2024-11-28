# Update package index and install Docker
apt-get update -y
sudo apt-get -y install curl lsb-release gnupg apt-transport-https ca-certificates software-properties-common

# Install Docker and Docker Compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable Docker and start it
systemctl enable docker
systemctl start docker

# Add the current user to the Docker group to allow running Docker without sudo
usermod -aG docker $USER
newgrp docker  # Refresh group membership without requiring logout

docker pull nginx
docker pull memcached
docker pull rabbitmq
docker pull tomcat:8-jre11
docker pull mysql:5.7.25

# Code build & deploy
apt install maven
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mvn install

# Build tomcat image
vim dockerfile
docker build -t tomcat_app:v1.0 .
docker run -d --name app tomcat_app:v1.0
docker ps
docker exec -ti app bash
docker rm -f app
docker rmi tomcat:8-jre11

# Build mysql image
vim dockerfile
docker build -t sql_db:v1.0 .
docker run -d --name db sql_db:v1.0

# Build nginx image
vim nginvproapp.conf
upstream vproapp {
server ?????:8080;         ## app IP address
}
server {
listen 80;
location / {
proxy_pass http://vproapp
}
}

vim dockerfile
docker build -t nginx_lb:v1.0 .
