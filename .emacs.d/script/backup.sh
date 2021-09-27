#!/bin/bash

BASEDIR="/mnt/HDDforBackup/" #バックアップ先の親ディレクトリ
LATESTBKUP=$(ls $BASEDIR | grep backup- | tail -n 1) #直近のバックアップのディレクトリ名

rsync -avh --link-dest="$BASEDIR/$LATESTBKUP" /mnt/HDDforData/ "/mnt/HDDforBackup/backup-$(date +%Y%m%d-%H%M%S)"
