#!/bin/bash -x
sudo docker run --runtime=cor -it --rm -p 5201:5201 --runtime=cor --net=vfnet1 --ip=192.168.0.12 -it mcastelino/iperf bash -c "mount -t ramfs -o size=20M ramfs /tmp; iperf3 -s"
