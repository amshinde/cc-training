if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

export OVS_DIR=/usr/src/ovs-branch-2.6

cd $OVS_DIR

# Clear current flows 
./utilities/ovs-ofctl del-flows br0 
 
# Add Flow for port 0 to port 1 and port 1 to port 0 
./utilities/ovs-ofctl add-flow br0 in_port=2,dl_type=0x800,idle_timeout=0,action=output:3
./utilities/ovs-ofctl add-flow br0 in_port=3,dl_type=0x800,idle_timeout=0,action=output:2
./utilities/ovs-ofctl add-flow br0 in_port=1,dl_type=0x800,idle_timeout=0,action=output:4
./utilities/ovs-ofctl add-flow br0 in_port=4,dl_type=0x800,idle_timeout=0,action=output:1


./utilities/ovs-ofctl dump-flows br0

sleep 1
