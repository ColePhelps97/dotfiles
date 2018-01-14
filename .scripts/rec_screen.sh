#!/bin/bash

RECS_DIR=$HOME/Videos/screen_records/
REC_NAME="screen_rec_`date '+%y_%m_%d-%H_%M_%S'`.mkv"

if [[ ! -d "${RECS_DIR}" ]]; then
	mkdir "${RECS_DIR}"
fi

ffmpeg \
	-f x11grab \
	-s $(xdpyinfo | grep dimensions | awk '{print $2}') \
	-i :0.0 \
	-c:v libx264 \
       	-qp 0 \
       	-r 60 \
	"$RECS_DIR$REC_NAME"

