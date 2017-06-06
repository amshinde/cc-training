if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
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
