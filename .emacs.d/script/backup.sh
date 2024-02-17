#!/bin/bash

# import
checkExist () {
    ls $1 > /dev/null 2>&1
}

error () {
    echo $1
    exit 1
}

# option analyze
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        #//// ここにオプションを追加していきます ////
        -o|--option) optFlg=$2; shift; shift;;
        --run) optFlg="run"; shift;;
        -e|--external) extFlg=$2; shift; shift;;
        -s|--source) srcFlg=$2; shift; shift;;
        --ssh) sshFlg=$2; shift; shift;;
        --) shift;  POSITIONAL_ARGS+=("$@"); set --;;
        -*) echo "[ERROR] Unknown option $1"; exit 1;;
        *)  POSITIONAL_ARGS+=("$1"); shift;;
    esac
done
set -- "POSITIONAL_ARGS[@]"  #// set $1, $2, ...
unset POSITIONAL_ARGS

# define variable

#バックアップディレクトリ名
date=$(date +%Y%m%d-%H%M%S)

OPT=$(case $optFlg in
          "") echo "-avhn";;
          "run") echo "-avh";;
          *) echo "-${optFlg//-/}";;
      esac)

OPTSSH=$(case $sshFlg in
             "") echo "";;
             *) echo "-e ssh";;
         esac)

#バックアップ先の親ディレクトリ
SNAP=$(case $srcFlg in
           "") echo "/mnt/HDDforBackup/";;
           *) echo $srcFlg;;
       esac)

backupDir=$(case $sshFlg in
                "") echo ${SNAP}backup-${date};;
                *) echo ${sshFlg}:${SNAP}backup-${date};;
            esac)

SRC=$(case $srcFlg in
          "") echo "/mnt/HDDforData/";;
          *) echo $srcFlg;;
      esac)


LINK="--link-dest=../backup-last"

# define function

#
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

# バックアップ
backup () {
    rsync $OPT $OPTSSH --exclude-from=<(excludeFile) $LINK $SRC $backupDir || \
        error "faild backup"
}

# 最新のバックアップのリンク
makeLink () {
    case $optFlg in
        # "run") ssh archlinuxrpi "cd /mnt/HDDforBackup; rm backup-last; ln -s ./backup-${date} ./backup-last" && \
        #              echo "make link" || error "cannot make link";;
        "run") funcLink && echo "make link" || error "cannot make link";;
        *) echo "dont make link";;
    esac
}

funcLink () {
    local linkExpr="cd ${SNAP}; rm backup-last; ln -s ./backup-${date} ./backup-last"
    case $sshFlg in
        "") eval "$linkExpr";;
        *) ssh $sshFlg "$linkExpr"
    esac
}

main () {
    backup && makeLink || error "faild main"
}

# funcLink

# run
# exit
main
