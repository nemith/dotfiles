#!/bin/bash
if [[ $(type -P scrot) && $(type -P convert) ]]; then
	img=$(mktemp --suffix=.png)
	scrot "$img"
	convert "$img" -scale 10% -scale 1000% "$img"
	[[ -f $1 ]] && convert $img $1 -gravity center -composite -matte $img
	i3lock -e -i "$img"
	rm "$img"
else
	i3lock
fi
