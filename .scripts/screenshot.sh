#!/bin/bash
BASEDIR="/home/`whoami`/Pictures/screen"
SCREEN_CMD="scrot"
SCREEN_CMD_OPTIONS=
VIEWER="feh"


#i3-msg "for_window [class="$VIEWER_CLASS"] floating enable"
FILENAME="${BASEDIR}/screen-`date '+%y-%m-%d-%H:%M:%S'`.png"

${SCREEN_CMD} -s -q 100 -e 'feh $f' "${FILENAME}"
#i3-msg "for_window [class="$VIEWER_CLASS"] floating disable"
xclip -selection clipboard -t image/png < "$FILENAME"
