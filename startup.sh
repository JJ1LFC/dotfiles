#!/bin/sh

apt update
apt full-upgrade -y
apt install zsh curl git vim neofetch -y
timedatectl set-timezone Asia/Tokyo
useradd alt -m -p '' -s /usr/bin/zsh
passwd --expire alt
gpasswd -a alt sudo
sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
systemctl restart sshd
sudo -u alt git clone https://github.com/JJ1LFC/dotfiles.git /home/alt/dotfiles
chown alt:alt /home/alt/
sudo -u alt sh /home/alt/dotfiles/install.sh
