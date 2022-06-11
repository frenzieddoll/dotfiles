#!/bin/bash

cat <<EOF > exclude-file
Downloads
Documents/programing
lost+found
SteamLibrary
EOF

BASEDIR="/mnt/HDDforBackup/" #バックアップ先の親ディレクトリ
LATESTBKUP=$(ls $BASEDIR | grep backup- | tail -n 1) #直近のバックアップのディレクトリ名

rsync -avh $1 --exclude-from='exclude-file' --link-dest="$BASEDIR/$LATESTBKUP" /mnt/HDDforData/ "/mnt/HDDforBackup/backup-$(date +%Y%m%d-%H%M%S)"
