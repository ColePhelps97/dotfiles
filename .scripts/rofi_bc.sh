#!/bin/bash

answer=$( echo "$@" | bc -l | sed 's/^\.\(.*$\)/0.\1/' )

action=$( echo -e "Clear\nCopy" | rofi -theme $HOME/.config/rofi/bc_config.rasi -dmenu -p "${answer}")

case $action in
	"Clear") $0 ;;
	"Copy") echo -n "${answer}" | xclip ;;
	"") ;;
	*) $0 "${answer} ${action}" ;;
esac

