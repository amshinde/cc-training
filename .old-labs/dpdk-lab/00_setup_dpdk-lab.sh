if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

SCRIPT_DIR=$(pwd)

echo "Starting OpenvSwitch..."
$SCRIPT_DIR/01_start_ovs.sh

echo "Creating OpenvSwitch ports..."
$SCRIPT_DIR/02_createports_ovs.sh

echo "Adding routes/flows..."
$SCRIPT_DIR/03_addroutes_vm-vm.sh

echo "Starting the VNF VM..."
$SCRIPT_DIR/04_start_VNF-VM.sh

echo "Starting the Tenant VM..."
$SCRIPT_DIR/05_start_TenantVM.sh
