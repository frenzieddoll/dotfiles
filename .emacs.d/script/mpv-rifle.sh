#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: ${0##*/} PICTURES"
    exit
fi

[ "$1" = '--' ] && shift

abspath () {
    case "$1" in
        /*) printf "%s\n" "$1";;
        ./*) printf "%s\n" "$(basename "$1")";;
        *)  printf "%s\n" "$PWD/$1";;
    esac
}

target="$(abspath "$1")"
find "$(dirname "$target")" -maxdepth 1 -type f -iregex '.*\(mp4\|mkv\|avi\|wmv\|webm\|mpg\|flv\|m4v\|rm\|rmvb\|mpeg\|asf\)$' | sort > playlist
count="$(grep -n "$1" playlist | cut -d ":" -f 1)"

if [ "$(wc -l playlist)" == 1 ]; then
    mpv $target
elif [ -n "$count" ]; then
    mpv --playlist=playlist --playlist-start=$(($count - 1))
else
    echo "error"
fi

rm playlist
