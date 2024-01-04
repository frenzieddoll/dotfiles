#!/bin/bash

input="$1"
path=$(dirname "$(readlink -f "$input")")
name=$(basename "$input" | sed -r 's/(\[|\])/\\\1/g')

fileList (){
    find "$path" -maxdepth 1 -type f -iregex '.*\(mp4\|mkv\|avi\|wmv\|webm\|mpg\|flv\|m4v\|rm\|rmvb\|mpeg\|asf\|mp3\)$' | sort
}

startCount (){
    echo "$(fileList | grep -n "$name" | cut -d ":" -f 1)-1" | bc
}

mpv --playlist=<(fileList) --playlist-start=$(startCount)
