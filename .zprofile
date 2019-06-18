# Add completions config dir
fpath=($HOME/.config/zsh $fpath)

# Go path
export GOPATH=$HOME/.godeps

# Set path
path+=(
	$HOME/bin # Custom executables
	$GOPATH/bin # Go binaries
	$HOME/.npm-global/bin # NPM binaries
	$HOME/.local/bin # Haskell stack path
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

. .env_secrets

# Use neovim as manpager
export MANPAGER="nvim -c 'set ft=man' -"
