if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

screen -dmS VNF_VM_SCREEN /home/user/training/dpdk-lab/start_VNF-VM.sh
sleep 3
ps ax | grep VNF
echo "*****VNF VM IP Address=192.168.120.10****"
