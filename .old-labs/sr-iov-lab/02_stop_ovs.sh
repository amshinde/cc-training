if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi
pkill -9 ovs
rm -rf /usr/local/var/run/openvswitch
rm -rf /usr/local/etc/openvswitch/
rm -f /tmp/conf.db


rmmod igb_uio
rmmod cuse
rmmod fuse
rmmod openvswitch
rmmod uio
rmmod eventfd_link
rmmod ioeventfd
rm -rf /dev/vhost-net

insmod i40e
insmod ixgbe


export DPDK_DIR=/usr/src/dpdk-16.07
export DPDK_BUILD=$DPDK_DIR/x86_64-native-linuxapp-gcc
python $DPDK_DIR/tools/dpdk-devbind.py --status

umount nodev /mnt/huge
mount | grep huge


