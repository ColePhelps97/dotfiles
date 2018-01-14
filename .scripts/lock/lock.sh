#!/bin/bash
ICON=$HOME/.scripts/locker/icon.png
TMPBG=/tmp/screen.png
SCREEN_WIDTH=`xdpyinfo | awk '/dimensions/{print $2}' | tr 'x' '\t' | awk '{print $1}'`
SCREEN_HEIGHT=`xdpyinfo | awk '/dimensions/{print $2}' | tr 'x' '\t' | awk '{print $2}'`
COLOR=#222222
BORDER_COLOR=#777777
TMP_INNER=/tmp/inner_square.png
TMP_OUTER=/tmp/outer_square.png
TMP_TIME_BG=/tmp/time_background.png
BORDER_SIZE=2
BG_WIDTH_REL=0.215
BG_HEIGHT_REL=0.15
BG_WIDTH_ABS=300
BG_HEIGHT_ABS=150
CORNER_X_MARGIN_REL=0.01
CORNER_Y_MARGIN_REL=0.01
CORNER_X_MARGIN_ABS=10
CORNER_Y_MARGIN_ABS=10
IS_SIZE_ABSOLUTE=0
IS_PADDING_ABSOLUTE=0

scrot -z /tmp/screen.png

#blur
convert $TMPBG -scale 10% -scale 1000% $TMPBG

#time/date bg
if (( $IS_SIZE_ABSOLUTE )); then
	ACTUAL_WIDTH=$BG_WIDTH_ABS
	ACTUAL_HEIGHT=$BG_HEIGHT_ABS
else
	ACTUAL_WIDTH=`echo "$BG_WIDTH_REL*$SCREEN_WIDTH" | bc`
	ACTUAL_WIDTH=${ACTUAL_WIDTH%%.*}
	ACTUAL_HEIGHT=`echo "$BG_HEIGHT_REL*$SCREEN_HEIGHT" | bc`
	ACTUAL_HEIGHT=${ACTUAL_HEIGHT%%.*}

fi

convert -size $(( $ACTUAL_WIDTH ))x$(( $ACTUAL_HEIGHT )) \
	xc:"${BORDER_COLOR}" $TMP_OUTER
convert -size $(( $ACTUAL_WIDTH - $BORDER_SIZE ))x$(( $ACTUAL_HEIGHT - $BORDER_SIZE )) \
	xc:"${COLOR}" $TMP_INNER

convert "${TMP_OUTER}" "${TMP_INNER}" -gravity center -composite "${TMP_TIME_BG}"
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG

if (( $IS_PADDING_ABSOLUTE )); then
	ACTUAL_X_MARGIN=$CORNER_X_MARGIN_AS
	ACTUAL_Y_MARGIN=$CORNER_Y_MARGIN_AS

else
	ACTUAL_X_MARGIN=`echo "$CORNER_X_MARGIN_REL*$SCREEN_WIDTH" | bc`
	ACTUAL_X_MARGIN=${ACTUAL_X_MARGIN%%.*}
	ACTUAL_Y_MARGIN=`echo "$CORNER_Y_MARGIN_REL*$SCREEN_HEIGHT" | bc`
	ACTUAL_Y_MARGIN=${ACTUAL_Y_MARGIN%%.*}
fi

convert $TMPBG $TMP_TIME_BG \
	-gravity southwest \
	-geometry +$(( $ACTUAL_X_MARGIN ))+$(( $ACTUAL_Y_MARGIN )) \
	-composite $TMPBG


i3lock -i $TMPBG -k -u \
       	--timecolor=777777ff \
	--timestr="%H:%M" \
       	--timefont="System San Francisco Display" \
	--timesize=100 \
	--timepos="$(( $ACTUAL_X_MARGIN )):$(( $SCREEN_HEIGHT - $ACTUAL_HEIGHT - 17 ))" \
	--time-align 0 \
	--datecolor=444444ff \
	--datestr="%A, %d %b %Y" \
       	--datefont="System San Francisco Display" \
	--date-align 0 \
	--datesize=30 \
	--datepos="$(( $ACTUAL_X_MARGIN )):$(( $SCREEN_HEIGHT - $ACTUAL_HEIGHT - 20 + $ACTUAL_HEIGHT / 3 ))" \
	2>/dev/null
