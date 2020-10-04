#!/bin/bash

echo " _              _           _  _       _    _  __  _   __               _"
echo "(_)            | |         | || |     (_)  (_)/_ || | / _|             | |"
echo " _  _ __   ___ | |_   __ _ | || |      _    _  | || || |_   ___      __| |  ___ __   __"
echo "| || '_ \ / __|| __| / _\` || || |     | |  | | | || ||  _| / __|    / _\` | / _ \\ \ / /"
echo "| || | | |\__ \| |_ | (_| || || | _   | |  | | | || || |  | (__  _ | (_| ||  __/ \ V /"
echo "|_||_| |_||___/ \__| \__,_||_||_|(_)  | |  | | |_||_||_|   \___|(_) \__,_| \___|  \_/"
echo "                                     _/ | _/ |"
echo "                                    |__/ |__/"

apt update
apt full-upgrade -y
apt install zsh curl git vim neofetch gnupg gpg-agent pinentry-curses tmux -y
curl -fsSL https://starship.rs/install.sh | bash
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
su -c "git clone https://github.com/JJ1LFC/dotfiles.git /home/alt/dotfiles" - alt
su -c "sh /home/alt/dotfiles/install.sh" - alt
chsh -s $(which zsh) alt
su -c "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm" - alt
su -c "neofetch --title_fqdn on --shell_path on --memory_percent on" - alt
