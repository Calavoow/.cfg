# Add completions config dir
fpath+=$HOME/.config/zsh

# Go path
export GOPATH=$HOME/.godeps

# Set path
path+=(
	$HOME/bin # Custom executables
	$GOPATH/bin # Go binaries
	$HOME/.npm-global/bin # NPM binaries
	$HOME/.local/bin # Haskell stack path
)

# export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"

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

# export to sub-processes (make it inherited by child processes)
# export PATH
