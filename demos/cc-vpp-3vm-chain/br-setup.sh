#!/bin/bash -x

# clean up:
sudo docker kill CC-C CC-B CC-A placeholder
sudo docker network rm lxbr_1
sudo docker network rm lxbr_2
sudo docker rm $(sudo docker ps -a -q) 
# Avoid looking for socket that is dead, since VPP doesn't clean these up
# at closure...
sudo rm /tmp/v_*

# Create two BR Networks
sudo docker network create --subnet=192.168.1.0/24 --gateway=192.168.1.1 lxbr_1
sudo docker network create --subnet=192.168.2.0/24 --gateway=192.168.2.1 lxbr_2

# create network placeholder runc container, which we'll shamelessly steal from
sudo docker run --runtime=runc --net=lxbr_1 --name placeholder --ip=192.168.1.2 -itd egernst/network-testing-ubuntu bash

#add network to placeholder
sudo docker network connect lxbr_2 placeholder --ip=192.168.2.2

sudo docker run --runtime=mine --net=container:placeholder --name "CC-B" -itd egernst/network-testing-ubuntu bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward; bash"
sudo docker run --runtime=mine --net=lxbr_1 --name "CC-A" --ip=192.168.1.10 -itd egernst/network-testing-ubuntu bash -c "ip route del default; ip route add default via 192.168.1.2; bash;"

sudo docker run --runtime=mine --net=lxbr_2 --name "CC-C" --ip=192.168.2.10 -itd egernst/network-testing-ubuntu bash -c "ip route del default; ip route add default via 192.168.2.2; bash;"

