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
