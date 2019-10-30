#!/bin/bash
sudo useradd -m -s /bin/bash ivaifua
sudo mkdir /home/ivaifua/.ssh
sudo cat /var/lib/jenkins/.ssh/jenkins.pub >> /home/ivaifua/.ssh/authorized_keys
sudo chown -R ivaifua:ivaifua /home/ivaifua
sudo chmod 600 /home/ivaifua/.ssh/authorized_keys
sudo touch ivaifua
sudo echo "ivaifua ALL=(ALL) NOPASSWD: ALL" > ivaifua
sudo mv ivaifua /etc/sudoers.d/
sudo mkdir /home/ivaifua/microservices
sudo mkdir /home/ivaifua/microservices/carts
sudo chown -R ivaifua:ivaifua /home/ivaifua/microservices
#sudo mv docker.sh /home/ivaifua
#sudo chown -R buildserver:buildserver /home/ivaifua/docker.sh
