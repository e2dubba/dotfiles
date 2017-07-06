# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1


#PROMPT
[[ -n $SSH_TTY ]] && host="%F{green}%m%f:"
precmd() {
  PROMPT="$host%F{blue}%~%f> "
  updates="$(xxd -ps $HOME/.updates)" 2> /dev/null
  branch=$(git branch | fgrep '*') 2> /dev/null
  if [[ -n $branch ]]; then
    [[ -n $(git status -s) ]] 2> /dev/null && colo='red' || colo='green'
    PROMPT="%F{$colo}${branch#* }%f|$PROMPT"
  fi
  [[ $updates != 00 && -n $updates ]] && PROMPT="%F{yellow}$updates%f|$PROMPT"
  [[ $USER = 'root' ]] && PROMPT="%F{yellow}%m%f:%F{red}%~%f# "
  PROMPT2=$(print -P $PROMPT|sed 's/././g')
}


setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

#source ~/.bashrc 
#source ~/.bash_profile

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 
source /home/svg/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.cargo/env

# aliases

alias info='info --vi-keys'
alias vim=nvim
alias ls='ls --color=auto'
export PATH="~/anaconda3/bin:$PATH"
export PATH="~/bin:$PATH"
export PATH="/home/svg/.local/bin:$PATH"

libgen() {
    url='http://gen.lib.rus.ec/search.php?req='"$@"
    w3m "$url"
}
c() {
    dir="$(dirlog-cd "$@")"
        if [ "$dir" != "" ]; then
            cd "$dir" && ls
        fi
}
tmux-helper() { 
	cd ~/bin/tmux-2.2
	nroff -mdoc tmux.1|less 
}
bibsync() {
	rsync --progress -r /home/svg/Documents/LIS452 echindod3@principal.dreamhost.com:Documents/
}
zathy() {
	zathura "$@" 2> /dev/null &
}
export PATH=/home/svg/.gem/ruby/2.3.0/bin:$PATH
