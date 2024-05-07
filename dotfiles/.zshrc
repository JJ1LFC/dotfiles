# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload '_history_substring_search_config'

# auto complete
autoload -Uz compinit && compinit
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:setopt:*' menu true select
zstyle ':completion:*:approximate' max-errors 2 NUMERIC
zstyle ':completion:*' completer _complete _correct
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt extended_glob


# others
setopt auto_cd
function chpwd() { ls -la }
setopt extended_glob
autoload -Uz colors
colors

# alias&keybind
alias la='ls -la'
alias mkdir='(){mkdir $1;cd $1}'
alias emacs='vim'
alias drill='drill -o rd'
bindkey -v
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# gpg-agent
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

# starship
eval "$(starship init zsh)"

# external source
zinit load zsh-users/zsh-syntax-highlighting
source ~/.local/share/zinit/plugins/zsh-users---zsh-history-substring-search/zsh-history-substring-search.zsh

