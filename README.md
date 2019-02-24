# Installing Ubuntu on the Legion Y530

This repository provides scripts and a step by step on how to get Ubuntu running on the Lenovo Legion Y530.


These steps were tested on a Legion with the following Specs:

* i7-8750H
* 16GB DDR4
* 1920x1080 Resolution (60Hz)
* 256GB NVMe SSD + 1TB Platter

However this should work on all configurations.

#### If at any point the machine becomes unresponsive, you can use Magic SysRq to reboot safely

Remember: *<b>R</b>eboot <b>E</b>ven <b>I</b>f <b>S</b>ystem <b>U</b>tterly <b>B</b>roken*

To use Magic SysRq, hold down the right Alt key and PrtSc, and then type (In Order) R, E, I, S, U, B. The machine should then reboot. If for some reason this doesn't work, then hold the power button down to power off the machine. 

#### If the machine freezes shortly after login or before the login screen appears, follow the steps section 'disable nouveau modeset' under Additional Notes. These steps will have to be followed at every boot until the nvidia drivers are installed. 
 
### Some things to note before Beginning:

* __This guide assumes decent knowledge of the Linux command line__
* __Following this guide will result in Windows being replaced with Ubuntu__
  * You can however, choose to install alongside your current OS
* __Several features of the Legion will be unavailable on Linux__
  * Screen Record Button - unknown to the keyboard driver?
  * Airplane Mode Button - generates event in linux live?
  * Camera Privacy Button - generates event in linux live?
  * Microphone Mute Button - Works in linux live?
  
  __The issues with some of the above buttons not mapping will be fixed with the kernel upgrade to v4.20__
      
##### Back up your data using Windows Backup or similar before continuing


Now that the important information is out of the way, let's begin

## 1. Download the Ubuntu disk image and imaging software
__NOTE: Using a version other than the latest LTS should work, but some guide steps may differ or not work__
* [Ubuntu 18.04.2 LTS](http://releases.ubuntu.com/18.04/ubuntu-18.04.2-desktop-amd64.iso)
* [Etcher](https://www.balena.io/etcher/)

## 2. Using Etcher, write the image to a USB Drive

After installing and opening Etcher, select your USB device and downloaded .iso and press the button labeled Flash!

![Etcher Screenshot](https://github.com/kfechter/LegionY530Ubuntu/raw/84dfd189e2f21102bcb7e97d45d539b353a55143/Images/etcherScreen.PNG "Etcher Screenshot")

![Etcher Screenshot 2](https://github.com/kfechter/LegionY530Ubuntu/raw/84dfd189e2f21102bcb7e97d45d539b353a55143/Images/etcherScreen2.PNG "Etcher Screenshot")

![Etcher Screenshot 3](https://github.com/kfechter/LegionY530Ubuntu/raw/84dfd189e2f21102bcb7e97d45d539b353a55143/Images/etcherScreen3.PNG "Etcher Screenshot")

## 3. Disable SecureBoot

Once Etcher has completed (It will show a screen with the message "Flash Complete"), you can close it. While Ubuntu can be installed with SecureBoot enabled, some drivers and features will not work. To disable, the machine needs to be booted into the UEFI settings. To get into UEFI settings, open the start menu in Windows and select restart while holding down shift. Hold down shift until you see the advanced option screen. 

![Advanced Startup](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/chooseOptions.jpg "Advanced Startup")

From this screen, select Troubleshoot, then Advanced Options, then UEFI Firmware Settings. 

![Troubleshoot](https://github.com/kfechter/LegionY530Ubuntu/blob/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/troubleshootOptions.jpg "Troubleshoot")

![Advanced Options](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/advancedOptions.jpg "Advanced Options")

After selecting UEFI Firmware settings, click the button labelled "Restart" on the screen that appears. 

Once in the UEFI settings, navigate to the Security tab using the arrow keys, then navigate down to 
Secure Boot. Press enter, select "Disabled" using the arrow keys, then press enter again. Once Secure Boot has been set to disabled, press F10 and select "Yes" to save the changes. 

![UEFI Firmware Setting](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/biosMain.jpg "UEFI Firmware Settings")

![Security Settings](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/biosSecurity.jpg "Security Settings")

## 4. Boot from the flash drive.

After selecting yes to save the settings, the machine will reboot. as soon as the reboot happens, start pressing the F12 button until you see the boot device selection screen. 

![Boot Device Selection](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/8234d4c4a473c91043bc3caae6725cc2e917647b/Images/bootManager.jpg "Boot Device Selection")

Select the flash drive and press enter to boot. on the screen that pops up, select "Try ubuntu without installing" or the equivalent option. 

## 5. Install Ubuntu

Once the live desktop loads, open a terminal and run the following command `sudo rmmod ideapad_laptop`. This command will enable wifi. If you are using a wired connection, this step isn't necessary.

If the above command does not get wifi working, you may need to perform steps under "Additional Notes" at the bottom.  

Select the "Install Ubuntu" icon on the desktop and follow the wizard to install Ubuntu on your desired drive. Once completed, select the option to restart the computer.

## 6. Install any available updates

once you are at the desktop, open the terminal and run `sudo rmmod ideapad_laptop` if you are using wifi. 

If the above command does not get wifi working, you may need to perform steps under "Additional Notes" at the bottom.    

Without closing the terminal, run the following command `sudo apt update && sudo apt dist-upgrade`. Follow any terminal prompts and when updates are complete, restart the computer. After rebooting, follow the above steps for getting wifi working. the next step will get wifi working permanently.

## 7. Use ukuu to update the kernel

### There have been many users having issues with kernel versions higher than 4.20.10. Choosing this version is the safest bet

open a terminal


If wifi is not working, try performing the following

run `sudo rmmod ideapad_laptop`

If the above command does not get wifi working, you may need to perform steps under "Additional Notes" at the bottom.  

once wifi is working (or if you are using wired ethernet)

run the command `sudo add-apt-repository ppa:teejee2008/ppa` and follow the prompt     
run the command `sudo apt-get install -y ukuu`

Open ukuu from the application screen, then find kernel v4.20 (or latest kernel/point release) in the list and select it for installation.

![Ukuu Screenshot](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/4772df4cd0484283c14f237402b8e941ed6b12ea/Images/ukuuScreen.PNG)

After the kernel is installed, reboot the laptop. Wifi should be working, but if it isnt follow the directions for Realtek Wifi cards underneath the additional notes section

## 8. Disable AER to prevent log spam (kernel 4.20.10 only)

After upgrading to kernel 4.20.10, there will be many warnings/errors displayed on boot. These errors contain the text 'aer' These warnings don't appear affect boot, but are annoying. PCIe AER can be disabled, which will prevent these messages.    

run the following command   
` sudo nano /etc/default/grub`    

Add 'pci=noaer' after quiet splash     

![Editing grub screenshot](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/b5b7f94ebf3d11b0945afccb7330c3aef548e36a/Images/nanoScreen.PNG)  

run the following command    
` sudo update-grub2`    

reboot

## 9. Install Nvidia drivers and Nvidia-prime packages. 

In the terminal, run the following commands, following any prompts    
`sudo add-apt-repository ppa:graphics-drivers/ppa`    
`sudo apt install -y nvidia-driver-415 nvidia-prime`

## 10. Verify that the Nvidia drivers and Prime packages are installed and configured correctly.
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

# Additional Notes

### Disable Nouveau Modeset

to disable modeset for the nouveau module, follow the below steps

reboot the machine, as soon as the screen turns purple (After the Legion logo screen), press esc. You should see a screen similar to the following.

![Selecting Ubuntu in Grub](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/0fc36c44e069d4e157faa4b16e87cc9625a7c0e1/Images/grubSelectionScreen.png)

highlight the entry that says "Ubuntu" and press 'e', you should get a screen that looks similar to the following.

![Adding Nouveau.modeset=0](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/0fc36c44e069d4e157faa4b16e87cc9625a7c0e1/Images/kernelOptions.png)

find the section that says 'quiet splash', and add nouveau.modeset=0 to it so it reads 'quiet splash noveau.modeset=0'

press F10 to boot with the changes.

### Nvidia Switching
With kernel 4.20, rebooting is no longer necessary to switch profiles, however log out and log in is still required.

### Wifi Fix for Realtek Cards

If your laptop has a Realtek Card, you will notice that doing the rmmod on ideapad_laptop won't fix the wifi. to get the wifi working, perform the following steps.

run the command `echo "options r8822be aspm=0" | sudo tee /etc/modprobe.d/r8822be.conf`    
run the command `sudo rmmod r8822be`    
run the command `sudo modprobe r8822be`

### Configuring Audio Jack to Work With Microphones

run the command `sudo nano /etc/modprobe.d/alsa-base.conf`    
add `options snd-hda-intel model=dell-headset-multi` to the end of the file    
reboot    

# Advanced Features

For multitouch touchpad gestures, you can install libinput-gestures from the below github repo.

https://github.com/bulletmark/libinput-gestures

# System Monitoring and Power Management

The following software can be used to monitor temperatures, adjust power management features, and control fans

* TLP - Allows for adjusting power management settings
     ` sudo apt install -y tlp tlp-rdw`    

* HTop - A more advanced version of top for monitoring system load
      ` sudo apt install -y htop`

* PowerTop - Process monitor that shows power usage of running processes
      ` sudo apt install -y powertop`
      
The following guide can be used to configure automatic fan control: [lm-sensors and pwmcontrol setup](http://tuxtweaks.com/2008/08/how-to-control-fan-speeds-in-ubuntu/)   

# Getting Airplane mode button working

The airplane mode button seems to work in TTY mode, but not in GUI mode. this can be fixed by setting the xmodmap for the keycode of the button in GUI mode. To get this working, follow the steps below. 

run the command `gedit ~/.Xmodmap`    
add the following contents, then save the file    
` keycode 255 = XF86WLAN NoSymbol XF86WLAN `   
run the following command ` gedit ~/.config/autostart/my-xmodmap.desktop`    
add the following content, replacing <username> with your username, then save the file          

``` 
[Desktop Entry]
Name=MyXmodmap   
Exec=/usr/bin/xmodmap /home/<username>/.Xmodmap
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
```
 
run the command ` chmod +x ~/.config/autostart/my-xmodmap.desktop`

restart the computer. 

The airplane mode button should now work properly

# Setting Governor to performance to prevent lag on battery

### This may decrease battery life, proceed with caution

The default governor for battery power is balanced. You may notice some lag in certain activities, most notably opening GNOME overview. You can use cpufrequtils to force the governor to performance, which mitigates these performance issues.

To configure cpufrequtils, follow the steps below:     

run the command ` sudo apt install -y cpufrequtils`    
run the command ` sudo nano /etc/default/cpufrequtils`    
add ` SCALING_GOVERNOR="performance"` to the end of the file     
run the command ` sudo systemctl disable ondemand`    
reboot the computer     
run the below command with the laptop unplugged. If the governor is set correctly, the terminal should output "performance"       
` cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor`   

the output of the above command will differ from the screenshot below based on your desktop environment, shell or CPU. the below screenshot is taken from 18.04 with GNOME desktop environment, zsh, and the 8750H (6C/12T)    

![CPU Freq Utils](https://raw.githubusercontent.com/kfechter/LegionY530Ubuntu/6a3c1c5ca35dd97c644b5ca68e8a2dc580136365/Images/cpufreqUtils.png)
