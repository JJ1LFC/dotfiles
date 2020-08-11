#!/bin/bash

### RUN CLOUD-INIT FIRST!! ###

set -eu

find /home/alt/dotfiles/dotfiles -type d | xargs -I '{}' mkdir -p "/home/alt/{}"
find /home/alt/dotfiles/dotfiles -type f | xargs -I '{}' ln -snfv "/home/alt/dotfiles/dotfiles{}" "/home/alt/{}"

echo "Dotfiles install success"
