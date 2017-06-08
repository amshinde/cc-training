export BDF1=0000\:01\:00.0
export BDF2=0000\:01\:00.1
export PF_IFACE1=enp1s0f0
export PF_IFACE2=enp1s0f1

# Kill running processes, remove existing databases:
sudo killall sriov
sudo rm /tmp/sriov.*

# Start things up:
sudo ~/go/bin/sriov &

# make sure vfio-pci is included:
sudo modprobe vfio-pci


#in case there were VFs already setup, let's reset to zero (note hardcoded bdf!)
echo 0 | sudo tee --append /sys/bus/pci/devices/$BDF1/sriov_numvfs
echo 0 | sudo tee --append /sys/bus/pci/devices/$BDF2/sriov_numvfs

# Grab a single VF per
echo 1 | sudo tee --append /sys/bus/pci/devices/$BDF1/sriov_numvfs
echo 1 | sudo tee --append /sys/bus/pci/devices/$BDF2/sriov_numvfs

lspci | grep thernet | grep Virtual

sudo docker network rm vfnet1
#sudo docker network rm vfnet2

sudo docker network create -d sriov --internal --opt pf_iface=$PF_IFACE1 --opt vlanid=100 --subnet=192.168.0.0/24 vfnet1
#sudo docker network create -d sriov --internal --opt pf_iface=$PF_IFACE2 --opt vlanid=100 --subnet=193.168.0.0/24 vfnet2

#sudo docker run --runtime=mine --net=vfnet1 --ip=192.168.0.10 -itd alpine sh
