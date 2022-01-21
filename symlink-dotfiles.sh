#!/bin/bash

# refered https://github.com/paulmillr/dotfiles/blob/master/etc/symlink-dotfiles.sh

dotfiles="$HOME/dotfiles"

echo ""
if [ -d "$dotfiles" ]; then
	echo "Symlinking dotfiles from $dotfiles"
else
	echo "$dotfiles does not exist"
	exit 1
fi

link() {
	from="$1"
	to="$2"
	echo "Linking '$from' to '$to'"
	rm -rf "$to"
	ln -s "$from" "$to"
}

for location in $(find home -name '.*' -maxdepth 1); do
	# "$location" == home/.*
	file="${location##*/}" # remove home/ from home/.*, i.e., .*
	# "$dotfiles/$location" == /home/yichangwang/dotfiles/home/.*
	link "$dotfiles/$location" "$HOME/$file"
done

link "$dotfiles/settings.json" "$HOME/.config/Code/User/settings.json"

source ~/.bash_profile;

unset file link
