if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

screen -dmS TENANT_VM_SCREEN /home/user/training/dpdk-lab/start_Tenant-VM.sh
sleep 3
ps ax |grep -i Tenant
echo "*****Tenant VM IP Address=192.168.120.11****"
