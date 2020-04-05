#!/bin/bash

src="/mnt/sdb/"
dst="/mnt/externalHDD/"
ops="-auhvP --delete"
ext="lost+found"

if [ "$1" == "run" ]
then
    echo "backup start"
    rsync $ops --exclude $ext $src $dst
else
    echo "backup pre start"
    rsync $ops -n --exclude $ext $src $dst
fi
