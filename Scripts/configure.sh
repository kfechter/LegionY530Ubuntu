#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

STATUS="PASS"

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

printf "\n"

printf "Operating System Information:\n"
printf "$(lsb_release -d | cut -f2) : ($(lsb_release -r | cut -f2))\n\n"

printf "Performing module remove on ideapad_laptop kernel module\n"
sudo rmmod ideapad_laptop
printf "\n"

wget -q --spider http://google.com
CONNECTED=$(echo $?)

while [ $CONNECTED -ne 0 ]; do
  read -n 1 -s -r -e -p "Please connect to a network (wired or wireless), then press any key"
  wget -q --spider http://google.com
  CONNECTED=$(echo $?)
done


printf "\nPerforming System Update\n"
sudo apt update && sudo apt dist-upgrade -y

printf "\nInstalling Nvidia Drivers and Nvidia Prime\n"

PS3='Which nvidia driver version do you want to install?  '
options=("1) nvidia-driver-390" "2) nvidia-driver-410")
select opt in "${options[@]}"
do
    case $opt in
        "1")
            echo "Installing Nvidia driver version 390"
	    sudo apt install nvidia-driver-390 nvidia-prime -y
	    break
            ;;
        "2")
            echo "Installing Nvidia driver version 410"
	    sudo add-apt-repository -y ppa:graphics-drivers/ppa
	    sudo apt install nvidia-driver-410 nvidia-prime -y
	    break
            ;;
        "Quit")
            break
            ;;
        *) 
	    echo "invalid option, defaulting to driver 390"
	    sudo apt install nvidia-driver-390 nvidia-prime -y
	    break
	    ;;
    esac
done

if ! grep -q "blacklist ideapad_laptop" /etc/modprobe.d/blacklist.conf; then
	printf "\nAdding ideapad_laptop to modprobe blacklist.conf\n"
	sudo printf "\n#Blacklist the ideapad_laptop module\nblacklist ideapad_laptop" >> /etc/modprobe.d/blacklist.conf
fi

printf "\nVerifying configuration of nvidia and nvidia-prime packages."

GPU="$(prime-select query)"

if [ "$GPU" = "nvidia" ]; then
    printf "\nTest 1 passes: Verify Nvidia profile is selected.\n"
else
    printf "\nExpected: nvidia\nGot: $GPU\nTest 1 Fails"
    STATUS="FAIL"
fi

SELECT="$(sudo prime-select intel)"

if [ "$SELECT" = "Info: selecting the intel profile" ]; then
    printf "Test 2 passes: Select Intel profile\n"
else
    printf "Expected: Info: selecting the intel profile\nGot: $SELECT\nTest 2 fails\n"
    STATUS="FAIL"
fi

GPU="$(prime-select query)"

if [ "$GPU" = "intel" ]; then
    printf "Test 3 passes: Verify Intel profile is selected\n"
else
    printf "Expected: intel\nGot: $GPU\nTest 3 fails\n"
    STATUS="FAIL"
fi

SELECT="$(sudo prime-select nvidia)"

if [ $SELECT = "Info: selecting the nvidia profile" ]; then
    printf "Test 4 passes: Switch back to Nvidia profile\n"
else
    printf "Expected: Info: selecting the nvidia profile\nGot: $SELECT\nTest 4 fails"
    STATUS="FAIL"
fi

GPU="$(prime-select query)"

if [ "$GPU" = "nvidia" ]; then
    printf "Test 5 passes: Verify Nvidia profile is selected\n"
else
    printf "Expected: nvidia\nGot: $GPU\nTest 5 fails\n"
    STATUS="FAIL"
fi

if [ "$STATUS" != "PASS" ]; then
    printf "\nNvidia Prime check failure, please remove all nvidia packages and try again"
else
    printf "Configuration tests passed. Nvidia prime is configured correctly.\n"

printf "\nScript Completed! Reboot to enable functionality\n"
