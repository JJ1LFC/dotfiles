# dotfiles for JJ1LFC

## Deploy
Run `startup.sh` as a startup script, or run `curl -L oru.to/install | sudo sh`.

## User other username
This is mainly for other people willing to use JJ1LFC's environment. Replace `__username__` to the string you want to set as a username.
```
curl -L oru.to/install | sed -e 's|alt|__username__|g' | sudo bash
```

