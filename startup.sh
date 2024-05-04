#!/bin/sh

apt update
apt full-upgrade -y
apt install zsh curl git vim gnupg gpg-agent scdaemon pinentry-curses tmux ibus-mozc -y
curl -sS https://starship.rs/install.sh | sh
timedatectl set-timezone Asia/Tokyo
if [ -z $(getent passwd alt) ]; then
    echo "##########
    ## adding user 'alt'
    ##########"
    useradd alt -m -p '' -s $(which zsh)
    #passwd --expire alt
    gpasswd -a alt sudo
    chown alt:alt /home/alt/
fi
sed -e 's/^#?PermitRootLogin.*$/PermitRootLogin no/' /etc/ssh/sshd_config
sed -e 's/^#?PasswordAuthentication.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd
su -c "git clone https://github.com/JJ1LFC/dotfiles.git /home/alt/dotfiles" - alt
su -c "sh /home/alt/dotfiles/install.sh" - alt
chsh -s $(which zsh) alt
su -c "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm" - alt

