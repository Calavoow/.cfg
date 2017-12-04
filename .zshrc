# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' completions 1
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '' '' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 2
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/eddie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# list colors
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
unsetopt listambiguous

# Reading keyboad
source ~/.config/zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
    [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
    [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char

# Backward search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# aliasses
#alias nvim='nvim --servername nvimserver'
alias vim='vim --servername vimserver'
alias vi='vim'
alias ls='ls --color=auto'
alias lc='ls -lh --color=auto --group-directories-first'
alias l='lc'
alias grep='grep --color=auto' # Always highlight grep search term
alias open='xdg-open'
alias config='/usr/bin/git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME'

# Cmd line calculator
alias bc='bc -l -q'
function calc () {
	if (($# == 0))
	then bc
	else echo $* | bc
	fi
}

function up {
	for a in {1..$1}
	do
		cd ../
	done
}

bindkey \\C-R history-incremental-search-backward
export TERM='xterm-256color'

autoload -U promptinit
promptinit
prompt walters green
PROMPT='%B%~>%b '
# RPROMPT="%F{${1:-green}}%n%f"

# Go path
export GOPATH=~/.godeps
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"

# NPM path
export PATH=$PATH:~/.npm-global/bin

# Stack path
export PATH=$PATH:~/.local/bin

bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Toggle vi
foreground-vi() {
  fg %vi
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

function zle-line-init zle-keymap-select {
    VIM_PROMPT="[% NORMAL]% "
    RPS1="%F{green}${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} %n%f $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Load ssh keys
# eval `keychain --eval --quiet --noask --agents ssh eddie`
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# Autosuggestions
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Syntax highlighting, call last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
