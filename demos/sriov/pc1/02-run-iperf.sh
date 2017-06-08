#!/bin/bash -x
sudo docker run --runtime=cor --net=vfnet1 --ip=192.168.0.11 -it mcastelino/iperf bash  -c "mount -t ramfs -o size=20M ramfs /tmp; iperf3 -c 192.168.0.12"
