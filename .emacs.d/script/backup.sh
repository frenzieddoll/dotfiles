#!/bin/bash

excludeFile () {
    cat <<EOF

lost+found
SteamLibrary
.Trash-1000

EOF
}

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        #//// ここにオプションを追加していきます ////
        -o|--option) optFlg=$2; shift; shift;;
        --run) optFlg="run"; shift;;
        -e|--external) extFlg=$2; shift; shift;;
        -s|--source) srcFlg=$2; shift; shift;;
        --) shift;  POSITIONAL_ARGS+=("$@"); set --;;
        -*) echo "[ERROR] Unknown option $1"; exit 1;;
        *)  POSITIONAL_ARGS+=("$1"); shift;;
    esac
done
set -- "POSITIONAL_ARGS[@]"  #// set $1, $2, ...
unset POSITIONAL_ARGS

#バックアップディレクトリ名
date=$(date +%Y%m%d-%H%M%S)

OPT=$(case $optFlg in
          "") echo "-avhn";;
          "run") echo "-avh";;
          *) echo "-${optFlg//-/}";;
      esac)

#バックアップ先の親ディレクトリ
SNAP=$(case $srcFlg in
           "") echo "/mnt/HDDforBackup/";;
           *) echo $srcFlg;;
       esac)

SRC="/mnt/HDDforData/"
LINK="--link-dest=../backup-last"

excludeFile () {
    local configFileDefault="./backup.config"
    case $extFlg in
        "")
            checkExist $configFileDefault && cat $configFileDefault || \
                    cat <<EOF
lost+found
SteamLibrary
.Trash-1000
EOF
            ;;
        *) cat $extFlg;;
    esac
}

checkExist () {
    ls $1 > /dev/null 2>&1
}

error () {
    echo $1
    exit 1
}

# バックアップ
backup () {
    rsync $OPT -e ssh --exclude-from=<(excludeFile) $LINK $SRC archlinuxrpi:${SNAP}backup-${date}
}

# 最新のバックアップのリンク
makeLink () {
    case $optFlg in
        "run") ssh archlinuxrpi "cd /mnt/HDDforBackup; rm backup-last; ln -s ./backup-${date} ./backup-last" && \
                     echo "make link" || error "cannot make link";;
        *) echo "dont make link";;
    esac
}

main () {
    backup && makeLink || error "error"
}

# exit
main
