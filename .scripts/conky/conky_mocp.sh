#!/bin/bash

ARTIST=$(mocp -Q "%artist")
SONG=$(mocp -Q "%song")
ALBUM=$(mocp -Q "%album")
CUR_TIME=$(mocp -Q "%ct")
TOTAL_TIME=$(mocp -Q "%tt")
FONT1=System San Franciso Display
FONT2=DejaVu Sans 

#echo -e "${ARTIST} - ${SONG}\n	${ALBUM}\n${CUR_TIME}/${TOTAL_TIME}"
#mocp -Q "%cs/%ts"
#mocp -Q "%cs/%ts" | bc -l | sed 's/^\.\(.*\)/0.\1/'
echo -e "\${font ${FONT1}:bold:size=12}\${color #333333}${CUR_TIME}/${TOTAL_TIME}\${color #555555}\${alignr}${SONG}\n\
\${font ${FONT2}:size=10}\${color #444444}${ALBUM}\${alignr}${ARTIST}\n\
\${color #333333}"
