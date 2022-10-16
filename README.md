# Realtek RTL8188FU Driver

**NOTE (from [kelebek333](https://github.com/kelebek333/rtl8188fu))**
This repository will may be deprecated as RTL8188FU module supports natively on Linux kernel.
https://patchwork.kernel.org/project/linux-wireless/patch/b14f299d-3248-98fe-eee1-ba50d2e76c74@gmail.com/

Unofficial drivers for RTL8188FU (WiFi dongle) for Linux kernel 4.15.x and newer.

**It is forked from kelebek333's RTL8188FU repository after it failed to compile on newer versions of Linux (>5.19.2 and >6.0.0).**

**ARM devices are not supported because I don't have one any.**

## Disclaimer
I'm not a driver developer. I don't have enough knowledge on how to use or fix these things below:

    - RTL8188FU

    - Linux driver headers

    - DKMS stuff

I'm creating this repository to have patches from kelebek333's original repository.

If you have issues with this driver (I might not fix) or suggest a feature, please
contact kelebek for assistance.

## Support
No support will be provided for other Linux distributions other than Arch Linux (I'm currently running on) and Debian (including derivatives).

## Installation

- Install required packages.

    *Make sure you know or read these packages on your package distribution page because you don't want
    to trust random people on the Internet...*

    ### Arch Linux
    ```sh
    sudo pacman -S git base-devel linux-headers dkms
    ```

    ### Debian

    ```sh
    sudo apt-get install build-essential git dkms linux-headers-$(uname -r)
    ```

- Clone (Like downloading the source code) the repository using git

    ```sh
    git clone https://github.com/memothelemo/rtl8188fu
    ```

- Add this driver to dkms

    ```sh
    sudo dkms add ./rtl8188fu
    ```

- Tell DKMS to compile that driver based on this directory we've cloned from git command.

    ```sh
    sudo dkms build rtl8188fu/1.0
    ```

- Install the driver after it compiles successfully
    ```sh
    sudo dkms install rtl8188fu/1.0
    ```

## Uninstallation

```sh
## Removes rtl8188fu from dkms modules list
sudo dkms remove rtl8188fu/1.0 --all

## Removes RTL8188FU configuration
sudo rm -f /etc/modprobe.d/rtl8188fu.conf
```

<!-- - Clone the binary 
`sudo cp ./rtl8188fu/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/` -->

## Configuration

<details>
<summary>My patches</summary>

I use RTL188FU and experienced issues upon installing from 
kelebek's forked driver natively.

I applied some patches in order to make this WiFi dongle work most of the time.

```sh
## Please read the contents of ./post-install.sh before running it!
## sudo is not neccessary if you're running on root
sudo bash ./post-install.sh
```

</details>

<details>
<summary>Disable Power Management</summary>

Run following commands for disable power management and plugging/replugging issues.

```sh
## Creates modprobe.d in /etc directory where we can keep our configurations in
sudo mkdir -p /etc/modprobe.d

## Creates rtl8188fu.conf file inside modprobe.d folder we created
sudo touch /etc/modprobe.d/rtl8188fu.conf

## Prints the text in the terminal and saves the output we show in terminal using tee
echo "options rtl8188fu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/rtl8188fu.conf
```

</details>

<details>
<summary>Disable MAC Address Spoofing</summary>

*Not neccessary if you're not running this on Ubuntu distributions and its derivates*

```sh
## Creates NetworkManager configuration file
sudo mkdir -p /etc/NetworkManager/conf.d

## Creates disable-random-mac.conf file to know NetworkManager we're
## going to disable MAC Address Spoofing
sudo touch /etc/NetworkManager/conf.d/disable-random-mac.conf

## Prints the text in the terminal and saves the output we show in terminal using tee
echo -e "[device]\nwifi.scan-rand-mac-address=no" | sudo tee /etc/NetworkManager/conf.d/disable-random-mac.conf
```

</details>

<details>
<summary>Blacklist for kernel 5.15 and 5.16 (No needed for kernel 5.17 and up)</summary>

If you are using kernel 5.15 and 5.16, you must create a configuration file with following commands for preventing to conflict rtl8188fu module with built-in r8188eu module.

```sh
echo 'alias usb:v0BDApF179d*dc*dsc*dp*icFFiscFFipFFin* rtl8188fu' | sudo tee /etc/modprobe.d/r8188eu-blacklist.conf
```

</details>
