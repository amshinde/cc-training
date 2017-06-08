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
#echo -e "\necho 0 > /sys/bus/pci/devices/0000\:01\:00.0/sriov_numvfs"
echo 0 | sudo tee --append /sys/bus/pci/devices/$BDF1/sriov_numvfs &> /dev/null
#echo -e "echo 0 > /sys/bus/pci/devices/0000\:01\:00.1/sriov_numvfs"
echo 0 | sudo tee --append /sys/bus/pci/devices/$BDF2/sriov_numvfs &> /dev/null


echo "lspci | grep Ethernet"
lspci | grep Ethernet

read -n1 -r -p "" key

echo -e "\n\ncat /sys/bus/pci/devices/0000\:01\:00.0/sriov_totalvfs"
cat /sys/bus/pci/devices/$BDF1/sriov_totalvfs

read -n1 -r -p "" key

# Grab a single VF per

echo -e "\n\necho 1 > /sys/bus/pci/devices/0000\:01\:00.0/sriov_numvfs"
echo 1 | sudo tee --append /sys/bus/pci/devices/$BDF1/sriov_numvfs

echo "echo 1 > /sys/bus/pci/devices/0000\:01\:00.1/sriov_numvfs"
echo 1 | sudo tee --append /sys/bus/pci/devices/$BDF2/sriov_numvfs

read -n1 -r -p "" key

echo "lspci | grep Ethernet"
lspci | grep Ethernet

read -n1 -r -p "" key

sudo docker network rm vfnet1 &> /dev/null


echo -e "\nsudo docker network create -d sriov --internal --opt pf_iface=$PF_IFACE1 --opt vlanid=100 --subnet=192.168.0.0/24 vfnet1"
sudo docker network create -d sriov --internal --opt pf_iface=$PF_IFACE1 --opt vlanid=100 --subnet=192.168.0.0/24 vfnet1



#sudo docker run --runtime=cor --net=vfnet1 --ip=192.168.0.11 -it mcastelino/iperf bash  -c "mount -t ramfs -o size=20M ramfs /tmp; iperf3 -c 192.168.0.12"
