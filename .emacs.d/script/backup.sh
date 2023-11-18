#!/bin/bash

excludeFile () {
    cat <<EOF
Downloads
Documents
lost+found
SteamLibrary
.Trash-1000
EOF
}

BASEDIR="/mnt/HDDforBackup/" #バックアップ先の親ディレクトリ
LATESTBKUP=$(ls $BASEDIR | grep backup- | tail -n 1) #直近のバックアップのディレクトリ名

rsync -avh $1 --exclude-from=<(excludeFile) --link-dest="$BASEDIR/$LATESTBKUP" /mnt/HDDforData/ "/mnt/HDDforBackup/backup-$(date +%Y%m%d-%H%M%S)"
