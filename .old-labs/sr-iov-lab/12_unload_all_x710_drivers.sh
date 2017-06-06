if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$RTE_SDK" == "" ]; then
        echo "Sorry, RTE_SDK has not been defined."
        exit 1
fi

rmmod i40e
rmmod i40evf
rmmod ixgbe
rmmod igb_uio
rmmod cuse
rmmod fuse
rmmod uio
rmmod eventfd_link
rmmod ioeventfd
umount /mnt/huge

python $RTE_SDK/tools/dpdk-devbind.py --status
