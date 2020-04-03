#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: ${0##*/} PICTURES"
    exit
fi

[ "$1" = '--' ] && shift

tmpfile=$(mktemp)
# 生成した一時ファイルを削除する
function rm_tmpfile {
  [[ -f "$tmpfile" ]] && rm -f "$tmpfile"
}
# 正常終了したとき
trap rm_tmpfile EXIT
# 異常終了したとき
trap 'trap - EXIT; rm_tmpfile; exit -1' INT PIPE TERM

abspath () {
    case "$1" in
        /*) printf "%s\n" "$1";;
        ./*) printf "%s\n" "$PWD/$(basename "$1")";;
        *)  printf "%s\n" "$PWD/$1";;
    esac
}

targetAbsPath="$(abspath "$1")"

targetFileName=$(echo $(basename "$targetAbsPath") | sed -e "s/\[/\\\[/g" | sed -e "s/\]/\\\]/g")
find "$(dirname "$targetAbsPath")" -maxdepth 1 -type f -iregex '.*\(mp4\|mkv\|avi\|wmv\|webm\|mpg\|flv\|m4v\|rm\|rmvb\|mpeg\|asf\)$' | sort > $tmpfile
# playlist=$(find "$(dirname "$target")" -maxdepth 1 -type f -iregex '.*\(mp4\|mkv\|avi\|wmv\|webm\|mpg\|flv\|m4v\|rm\|rmvb\|mpeg\|asf\)$' | sort)
count="$(grep -n "$targetFileName" $tmpfile | cut -d ":" -f 1)"

# mpv --playlist=$tmpfile --playlist-start=$(($count - 1))
if [ "$(wc -l $tmpfile)" == 1 ]; then
    mpv $target
elif [ -n "$count" ]; then
    mpv --playlist=$tmpfile --playlist-start=$(($count - 1))
else
    echo "error"
fi
