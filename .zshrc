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
zstyle :compinstall filename '$HOME/.zshrc'

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

# Backward search
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# aliasses
#alias nvim='nvim --servername nvimserver'
alias vi='vim'
alias ls='ls --color=auto'
alias lc='ls -lh --color=auto --group-directories-first'
alias l='lc'
alias grep='grep --color=auto' # Always highlight grep search term
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# OS specific commands
case `uname` in
	Darwin)
		# MacOs
		# OSX working dir
		precmd () {print -Pn "\e]2; %~/ \a"}
		preexec () {print -Pn "\e]2; %~/ \a"}

		# GNU coreutils
		# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
		# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	;;
	*)
		# Other OSes
		alias open='xdg-open'
		alias vim='vim --servername vimserver'
	;;
esac

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

# Custom executables
# PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Go path
# export GOPATH=$HOME/.godeps
# PATH="$PATH:$GOPATH/bin"
# export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"

# NPM path
# PATH=$PATH:$HOME/.npm-global/bin

# Stack path
# export PATH=$PATH:~/.local/bin

# Pipenv config
export PIPENV_VENV_IN_PROJECT=1
export PIPENV_SHELL_FANCY=1

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

# Git set SSH client
export GIT_SSH="/usr/bin/ssh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load rbenv
eval "$(rbenv init -)"
