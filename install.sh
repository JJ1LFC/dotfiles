#!/bin/sh

set -eu

cd /home/alt/dotfiles/dotfiles

find . -type d | xargs -I '{}' mkdir -p "/home/alt/{}"
find . -type f | xargs -I '{}' ln -snfv "/home/alt/dotfiles/dotfiles/{}" "/home/alt/{}"

echo "Dotfiles install success"
