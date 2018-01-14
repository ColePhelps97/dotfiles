#!/bin/bash

DAY=$( date +%e )
ncal -hMb | fold -w 21 | \
	sed '/^[[:space:]]*$/d' | \
	sed 's/^\(.*\)$/${alignc}\1/' | \
	sed "s/$DAY/\${color #777777}$DAY\${color #444444}/g"
