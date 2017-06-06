if [ "$( id -u )" == "0" ]; then
        echo "Sorry, you may NOT run this script as root."
        exit 1
fi

SCRIPT_DIR=$(pwd)

echo "Stopping the VMs..."
$SCRIPT_DIR/11_stop_VMs.sh

echo "Stopping OpenvSwitch..."
sudo $SCRIPT_DIR/12_stop_ovs.sh
echo "Unloading DPDK..."
sudo $SCRIPT_DIR/13_unload_dpdk.sh
