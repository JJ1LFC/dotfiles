#!/bin/sh

set -eu

cd /home/alt/dotfiles/dotfiles

find . -type d | xargs -I '{}' mkdir -p "/home/alt/{}"
find . -type f | xargs -I '{}' ln -snfv "/home/alt/dotfiles/dotfiles/{}" "/home/alt/{}"

find . -type d | xargs -I '{}' chmod 755 "/home/alt/{}"
find . -type f | xargs -I '{}' chmod 755 "/home/alt/{}"
chmod 600 /home/alt/dotfiles/dotfiles/.ssh/authorized_keys


echo "Dotfiles install success"
