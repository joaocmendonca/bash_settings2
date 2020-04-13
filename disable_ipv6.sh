#!/bin/bash
## Author: Joao C. Mendonca
## Date: Mar 30, 2020
## License: MIT License
## For usage and references check README

### Script must be run as root
# if [ $UID -ne 0 ]; then
if [ "$(id -u)" -ne 0 ]; then
   echo "You need to be root to run this script!"
   exit 1
   else
     echo "[*] You are root, continuing..."
fi

# disable ipv6
echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/01-disable-ipv6.conf
