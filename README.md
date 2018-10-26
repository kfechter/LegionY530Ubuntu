## Use the [master](https://github.com/kfechter/LegionY530Ubuntu/tree/master "master branch") branch, as things here may not have been tested


# Installing Ubuntu on the Legion Y530

This repository provides scripts and a step by step on how to get Ubuntu running on the Lenovo Legion Y530.


These steps were tested on a Legion with the following Specs:

* i7-8750H
* 16GB DDR4
* 1920x1080 Resolution (60Hz)
* 256GB NVMe SSD + 1TB Platter

However this should work on all configurations.

### Some things to note before Beginning:

* __This guide assumes decent knowledge of the Linux command line__
* __Following this guide will result in Windows being replaced with Ubuntu__
  * You can however, choose to install alongside your current OS
* __Several features of the Legion will be unavailable on Linux__
  * Screen Record Button - unknown to the keyboard driver?
  * Airplane Mode Button - generates event in linux live?
  * Camera Privacy Button - generates event in linux live?
  * Microphone Mute Button - Works in linux live?
* __18.10 seems to have issues with USB 3.0 flash drives. 2.0 drives work fine.__
  
  
  ###### The current reccomended versions of Ubuntu are as follows
    * LTS: 18.04.1 or latest point release
    * Non-LTS: 18.10
    
##### Back up your data using Windows Backup or similar before continuing


Now that the important information is out of the way, let's begin

## 1. Download the Ubuntu disk image and imaging software
* Ubuntu
  * [18.04.1 LTS](http://releases.ubuntu.com/18.04/ubuntu-18.04.1-desktop-amd64.iso) 
  * [18.10](http://releases.ubuntu.com/18.10/ubuntu-18.10-desktop-amd64.iso)
* [Etcher](https://etcher.io/)

## 2. Using Etcher, write the image to a USB Drive

After installing and opening Etcher, select your USB device and downloaded .iso and press the button labeled Flash!

![Etcher Screenshot](https://github.com/kfechter/LegionY530Ubuntu/raw/master/Images/etcher3.PNG "Etcher Screenshot")

## 3. Disable SecureBoot

Once Etcher has completed (It will show a screen with the message "Flash Complete"), you can close it. While Ubuntu can be installed with SecureBoot enabled, some drivers and features will not work. To disable, the machine needs to be booted into the UEFI settings. To get into UEFI settings, open the start menu in Windows and select restart while holding down shift. Hold down shift until you see the advanced option screen. 

![Advanced Startup](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/20180827_200528.jpg "Advanced Startup")

From this screen, select Troubleshoot, then Advanced Options, then UEFI Firmware Settings. 

![Troubleshoot](https://github.com/kfechter/LegionY530Ubuntu/blob/master/Images/20180827_200536.jpg "Troubleshoot")

![Advanced Options](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/20180827_200543.jpg "Advanced Options")

After selecting UEFI Firmware settings, click the button labelled "Restart" on the screen that appears. 

Once in the UEFI settings, navigate to the Security tab using the arrow keys, then navigate down to 
Secure Boot. Press enter, select "Disabled" using the arrow keys, then press enter again. Once Secure Boot has been set to disabled, press F10 and select "Yes" to save the changes. 

![UEFI Firmware Setting](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/20180827_200626.jpg "UEFI Firmware Settings")

![Security Settings](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/20180827_200636.jpg "Security Settings")

## 4. Boot from the flash drive.

After selecting yes to save the settings, the machine will reboot. as soon as the reboot happens, start pressing the F12 button until you see the boot device selection screen. 

![Boot Device Selection](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/20180827_220001.jpg "Boot Device Selection")

Select the flash drive and press enter to boot. on the screen that pops up, select "Try ubuntu without installing" or the equivalent option. 

## 5. Install Ubuntu

Once the live desktop loads, open a terminal and run the following command `sudo rmmod ideapad_laptop`. This command will enable wifi. If you are using a wired connection, this step isn't necessary, and a later step will permanently disable this module so wifi always works. 

Select the "Install Ubuntu" icon on the desktop and follow the wizard to install Ubuntu on your desired drive. Once completed, select the option to restart the computer.

__NOTE: At this point, if you want to run the automated script, download configure.sh from the scripts directory in the repo, and run it with the following command `sudo bash ./configure.sh` (in the directory you downloaded the script to). Follow the terminal prompts and the machine will be configured and reboot. If all is successful you have completed the guide. If you want to perform the manual steps, continue to step 7 below.__

## 6. Install any available updates

once you are at the desktop, open the terminal and run `sudo rmmod ideapad_laptop` if you are using wifi. without closing the terminal, run the following command `sudo apt-update && sudo apt dist-upgrade`. Follow any terminal prompts and when updates are complete, leave the terminal open.

## 7. Permanently blacklist ideapad_laptop

To allow Wi-Fi to work every boot without having to use rmmod, the ideapad_laptop module must be added to the modprobe blacklist.

run the command `sudo gedit /etc/modprobe.d/blacklist.conf` and add blacklist ideapad_laptop to the end of the file. Save changes and close the editor. 

![Edit Blacklist](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/master/Images/Ubuntu.png "Editing Blacklist")

## 8. Install Nvidia drivers and Nvidia-prime packages. 

In the terminal, run the following command `sudo apt install nvidia-driver-390 nvidia-prime`. Follow all the prompts to install the drivers and required packages.

## 9. Verify that the Nvidia drivers and Prime packages are installed and configured correctly.
run the following series of commands and verify the output

```
prime-select query 
``` 
Should output 'nvidia'
```
sudo prime-select intel 
```
Should output text similar to 'Selecting profile intel'
```
prime-select query 
```
Should now output 'intel'

If the above commands complete successfully, then you have successfully configured your Legion Y530 with Ubuntu.
