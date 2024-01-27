#!/bin/bash

excludeFile () {
    cat <<EOF
Downloads
Pictures/darktable
Pictures/camera
Music
Videos/Geheimnis
Videos/reinoare

lost+found
SteamLibrary
.Trash-1000
Documents

EOF
}

#バックアップ先の親ディレクトリ
BASEDIR="/mnt/samba/"

#直近のバックアップのディレクトリ名
LATESTBKUP=$(ls $BASEDIR | grep backup- | grep -v last | tail -n 1)

#バックアップディレクトリ名
NEWBKUP=$(date +%Y%m%d-%H%M%S)

# バックアップ
rsync -avh $1 --exclude-from=<(excludeFile) --link-dest="$BASEDIR/$LATESTBKUP" /mnt/HDDforData/ "$BASEDIR/backup-$NEWBKUP"

# 最新のバックアップのリンク
cd $BASEDIR
ln -fs ./backup-$NEWBKUP ./backup-last
