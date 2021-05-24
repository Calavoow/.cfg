# Add completions config dir
fpath=($HOME/.config/zsh $fpath)

# Go path
export GOPATH=$HOME/.godeps

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"

# Set path
path+=(
	$HOME/bin # Custom executables
	$GOPATH/bin # Go binaries
	$HOME/.npm-global/bin # NPM binaries
	$HOME/.local/bin # Haskell stack path
	$PYENV_ROOT/bin # Python binaries
	$HOME/.poetry/bin:$PATH # Python poetry binary
)

# OS specific commands
case `uname` in
	Darwin)
		# MacOs
		# GNU coreutils
		path=('/usr/local/opt/coreutils/libexec/gnubin' $path)
		manpath=('/usr/local/opt/coreutils/libexec/gnuman' $manpath)
	;;
	*)
		# Other OSes
		alias open='xdg-open'
		alias vim='vim --servername vimserver'
	;;
esac

# GPG TTY fix
GPG_TTY=$(tty)
export GPG_TTY

. $HOME/.env_secrets

# Use neovim as manpager
export MANPAGER="nvim -c 'set ft=man' -"
