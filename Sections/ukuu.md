# Use ukuu to update the kernel

##### :no_entry_sign: Updating the kernel to something outside of the kernel shipped with Ubuntu LTS can cause issues. Support for these changes is limited. You assume all risks when performing the following steps.

##### Remember: if this breaks your system, you are allowed to keep both halves

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
