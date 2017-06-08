export BDF1=0000\:02\:10.0
export BDF2=0000\:02\:10.1
echo $BDF1 | sudo tee --append /sys/bus/pci/drivers/vfio-pci/unbind
echo $BDF1 | sudo tee --append /sys/bus/pci/drivers/ixgbevf/bind
echo $BDF2 | sudo tee --append /sys/bus/pci/drivers/vfio-pci/unbind
echo $BDF2 | sudo tee --append /sys/bus/pci/drivers/ixgbevf/bind

echo 8086 1515 | sudo tee --append /sys/bus/pci/drivers/vfio-pci/remove_id

