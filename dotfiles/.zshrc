# zplug
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "plugins/git",   from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zplug/zplug", hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load –verbose


# auto complete
autoload -Uz compinit && compinit
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups
setopt share_history
setopt extended_glob


# others
setopt auto_cd
function chpwd() { ls -la }
bindkey -v
setopt extended_glob
autoload -Uz colors
colors
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})┬─%{${fg[green]}%}[%{${fg[yellow]}%}%n%{${reset_color}%}@%{${fg[blue]}%}%M%{${reset_color}%}:%~%{${fg[green]}%}]%(?.%{${fg[green]}%}.%{${fg[red]}%})─[%*]
╰─>%{${reset_color}%}%# "

# alias
alias la='ls -la'

if (( ${+commands[gpg]} )); then
    # Start the gpg-agent if not already running
    if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
      gpg-connect-agent /bye >/dev/null 2>&1
    fi
    # Set SSH to use gpg-agent
    unset SSH_AGENT_PID
    if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    # Set GPG TTY
    export GPG_TTY="$(tty)"
    # Refresh gpg-agent tty in case user switches into an X session
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi
