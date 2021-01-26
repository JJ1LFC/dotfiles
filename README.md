# dotfiles for JJ1LFC

## Deploy
Run `startup.sh` as a startup script, or run `curl -L install.jj1lfc.dev | sudo bash`.

## User other username
This is mainly for other people willing to use JJ1LFC's environment. Replace `__username__` to the string you want to set as a username.
```
curl -L install.jj1lfc.dev | sed -e 's|alt|__username__|g' | sudo bash
```

## Login shell
After using this, the login shell is set to be zsh (`/usr/bin/zsh`). If fish is preferable, do:
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
chsh -s $(which fish)
```
