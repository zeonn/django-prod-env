# packages
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
# docker
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-get install -y docker-engine
usermod -aG docker $(whoami)
docker -v
# docker-compose
curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose
docker-compose -v
