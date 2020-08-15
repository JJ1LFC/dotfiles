# dotfiles for JJ1LFC

## Deploy
1. Run `startup.sh` as a startup script, or run `curl -L install.jj1lfc.dev | bash` as root
2. That's all!

## Login shell
After using this, the login shell is set to be zsh (`/usr/bin/zsh`). If fish is preferable, do:
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
chsh -s $(which fish)
```
