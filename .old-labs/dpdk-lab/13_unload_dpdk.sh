if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$RTE_SDK" == "" ]; then
	echo "Sorry, RTE_SDK has not been defined."
	exit 1
fi

if [ "$RTE_TARGET" == "" ]; then
	echo "Sorry, RTE_TARGET has not been defined."
	exit 1
fi

export PCI_PORT_0="00:09.0"
export PCI_PORT_1="00:0a.0"
DRIVER="i40evf"

insmod i40e
insmod i40evf
insmod ixgbe


echo "Binding $PCI_PORT_0 to $DRIVER"
python $RTE_SDK/tools/dpdk-devbind.py --bind=$DRIVER $PCI_PORT_0
echo "Binding $PCI_PORT_1 to $DRIVER"
python $RTE_SDK/tools/dpdk-devbind.py --bind=$DRIVER $PCI_PORT_1

rmmod igb_uio
rmmod cuse
rmmod fuse
rmmod uio
rmmod eventfd_link
rmmod ioeventfd

python $RTE_SDK/tools/dpdk-devbind.py --status

umount /mnt/huge

cat /proc/meminfo


