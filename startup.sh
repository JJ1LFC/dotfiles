#!/bin/bash

echo "\
 _              _           _  _       _    _  __  _   __               _
(_)            | |         | || |     (_)  (_)/_ || | / _|             | |
 _  _ __   ___ | |_   __ _ | || |      _    _  | || || |_   ___      __| |  ___ __   __
| || '_ \ / __|| __| / _` || || |     | |  | | | || ||  _| / __|    / _` | / _ \\ \ / /
| || | | |\__ \| |_ | (_| || || | _   | |  | | | || || |  | (__  _ | (_| ||  __/ \ V /
|_||_| |_||___/ \__| \__,_||_||_|(_)  | |  | | |_||_||_|   \___|(_) \__,_| \___|  \_/
                                     _/ | _/ |
                                    |__/ |__/
"

apt update
apt full-upgrade -y
apt install zsh curl git vim neofetch -y
timedatectl set-timezone Asia/Tokyo
if [ -z $(getent passwd alt) ]; then
    echo "##########
    ## adding user 'alt'
    ##########"
    useradd alt -m -p '' -s /usr/bin/zsh
    passwd --expire alt
    gpasswd -a alt sudo
    chown alt:alt /home/alt/
fi
sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
systemctl restart sshd
sudo -u alt git clone https://github.com/JJ1LFC/dotfiles.git /home/alt/dotfiles
sudo -u alt sh /home/alt/dotfiles/install.sh
chsh -s $(which zsh) alt
sudo -u alt neofetch --title_fqdn on --shell_path on --memory_percent on
