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
  * Screen Record Button
  * Airplane Mode Button
  * Camera Privacy Button
  * Microphone Mute Button
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

## Install Ubuntu

Once the live desktop loads, open a terminal and run the following command (without quotes) 'sudo rmmod ideapad_laptop'. This command will enable wifi. If you are using a wired connection, this step isn't necessary, and a later step will permanently disable this module so wifi always works. 

Select the "Install Ubuntu" icon on the desktop and follow the wizard to install Ubuntu on your desired drive. Once completed, select the option to restart the computer.

## Boot Ubuntu with Nouveau modeset disabled.

Due to the Nvidia Optimus switchable graphics, booting without modeset disabled will result in a non working desktop. To disable modesetting, after the Legion boot screen but before Ubuntu start loading, press the escape button until you see the Grub boot menu. on this screen, highlight the Ubuntu option and press e. On the screen that follows, find the line containing "quiet splash" and edit it so that it reads "quiet splash nouveau.modeset=0". Press F10 to boot with the options. 

![]()

![]()
