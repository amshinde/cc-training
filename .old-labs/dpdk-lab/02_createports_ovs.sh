
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi


OVS_DIR=/usr/src/ovs-branch-2.6

echo "Set PMD cores: 1 core"
$OVS_DIR/utilities/ovs-vsctl set Open_vSwitch . other_config:pmd-cpu-mask=4 #1core

echo "Done"
sleep 5

echo "Create bridge br0 and vhost ports"
#create vhost ports
$OVS_DIR/utilities/ovs-vsctl add-br br0 -- set bridge br0 datapath_type=netdev
sleep 3
$OVS_DIR/utilities/ovs-vsctl add-port br0 vhost-user0 -- set Interface vhost-user0 type=dpdkvhostuser
sleep 3
$OVS_DIR/utilities/ovs-vsctl add-port br0 vhost-user1 -- set Interface vhost-user1 type=dpdkvhostuser
sleep 3
$OVS_DIR/utilities/ovs-vsctl add-port br0 vhost-user2 -- set Interface vhost-user2 type=dpdkvhostuser
sleep 3
$OVS_DIR/utilities/ovs-vsctl add-port br0 vhost-user3 -- set Interface vhost-user3 type=dpdkvhostuser

echo "Show br0 info:"
$OVS_DIR/utilities/ovs-vsctl show


