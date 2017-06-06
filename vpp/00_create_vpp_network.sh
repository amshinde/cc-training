#Cleanup any old VPP interfaces, and kill the existing plugin (if running):
sudo service vpp stop
sudo killall vpp
sudo service vpp start

#start the CNM plugin:
sudo $GOPATH/bin/vpp &

#Create the VPP container network using the custom VPP docker driver
sudo docker network rm vpp_net
sudo docker network create -d=vpp --ipam-driver=vpp --subnet=192.168.1.0/24 --gateway=192.168.1.1 vpp_net

sudo docker network ls
