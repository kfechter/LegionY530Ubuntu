# Common Issues and how to solve them

### WiFi Doesn't work

open a terminal and run the command `lspci | grep -i realtek` If you see a line containing a realtek wifi card, then follow these steps to configure the realtek module and get wifi working

run the command `echo "options r8822be aspm=0" | sudo tee /etc/modprobe.d/r8822be.conf`    
run the command `sudo rmmod r8822be`    
run the command `sudo modprobe r8822be`

##### NOTE: The below bug has fixes released

~~As stated in below bug request this process doesn't work for Kernel version 4.18.0-12 and higher. You would get 'Operation not permitted' error on last command. Disabling 'Secure Boot' in BIOS would fix the problem as stated in comments of bug request.~~

~~https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1806472~~


### Laptop seems to freeze before/after/during login screen

If your laptop seems to freeze at any point before installing the nvidia drivers, you may need to disable nouveau modeset during boot until the drivers are installed. To disable modeset, follow the steps below.

reboot the machine either by Magic SysRq or by holding the power button down and turning it back on.

As soon as the screen turns purple (After the Legion logo screen), press esc. You should see a screen similar to the following.

![Selecting Ubuntu in Grub](../Images/grubSelectionScreen.png)

highlight the entry that says "Ubuntu" and press 'e', you should get a screen that looks similar to the following.

![Adding Nouveau.modeset=0](../Images/kernelOptions.png)

find the section that says 'quiet splash', and add nouveau.modeset=0 to it so it reads 'quiet splash noveau.modeset=0'

press F10 to boot with the changes.


### Nvidia switching doesn't seem to be working (i.e, nvidia mode enabled and external screens don't work)

if after doing sudo prime-select nvidia, you notice that external screens don't work. Try logging out and back in. If they still don't work, then reboot the machine. 

##### __Note: If you deviate from the stock kernel, this may cause issues with the nvidia drivers__

### Ubuntu doesn't detect my disk drives/Doesn't detect Windows is installed.

Kudos to Github user [@tommyalvarez](https://github.com/tommyalvarez) and [This site](https://davidvielmetter.com/tricks/installing-ubuntu-dual-boot-on-a-dell-precision-which-already-runs-windows-10/) for this information

The most likely cause is you have optane. You can confirm this by opening PowerShell as an administrator and running the following command 

` Get-PhysicalDisk`

If the output contains a device with a FriendlyName of Intel Optane+<xxxGB>HDD Where xxx will be a capacity, you have optane. To get ubuntu installed in a dual boot scenario with optane follow the steps below. 

Instead of selecting "Install Ubuntu," select the "Try Ubuntu" option. Then open a terminal and issue the following command

` sudo dmraid -E -r /dev/sda`

It will ask if you want to delete metadata, you can say yes to this. 

You can now exit the terminal and follow the guide to install Ubuntu in a dualboot scenario
