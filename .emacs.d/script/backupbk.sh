#!/bin/bash

src="/mnt/sdc/frenz/"
dst="/mnt/sdb/"
ops="-auhvP"

if [ "$1" == "all" ]
then

    echo "backup Documents"
    rsync -auhv --progress  $src/Documents/ $dst/Documents/
    echo "backup Pictures"
    rsync -auhv --progress $src/Pictures/ $dst/Pictures/
    echo "backup Videos"
    rsync -auhv --progress $src/Videos/ $dst/Videos/
    echo "backup Music"
    rsync -auhv --progress $src/Music/ $dst/Music/
    echo "backup home"
    rsync -auhv --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ $dst/home/toshiaki/

elif [ "$1" == "dpv" ]
then

    echo "backup Documents"
    rsync -auhv --progress  $src/Documents/ $dst/Documents/
    echo "backup Pictures"
    rsync -auhv --progress $src/Pictures/ $dst/Pictures/
    echo "backup Videos"
    rsync -auhv --progress $src/Videos/ $dst/Videos/
    # echo "backup Music"
    # rsync -auhv --progress $src/Music/ $dst/Music/
    # echo "backup home"
    # rsync -auhv --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ $dst/home/toshiaki/


elif [ "$1" == "delete" ]
then
    # echo "backup Documents"
    # rsync -auhv --progress --delete  $src/Documents/ $dst/Documents/
    echo "backup Pictures"
    rsync -auhv --progress --delete $src/Pictures/ $dst/Pictures/
    echo "backup Videos"
    rsync -auhv --progress --delete $src/Videos/ $dst/Videos/
    echo "backup Music"
    rsync -auhv --progress --delete $src/Music/ $dst/Music/
    # echo "backup home"
    # rsync -auhv --progress --delete --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ $dst/home/toshiaki/

elif [ "$1" == "documents" ]
then
     echo "backup Documents"
     rsync -auhvn --progress  $src/Documents/ $dst/Documents/

elif [ "$1" == "home" ]
then
     echo "backup home"
     rsync -auhvn --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/ --exclude=  /home/toshiaki/ $dst/home/toshiaki/

elif [ "$1" == "td" ]
then
    echo -e "test Documents\n"
    echo "backup Documents"
    rsync -auhvn --progress  $src/Documents/ $dst/Documents/

elif [ "$1" == "th" ]
then
   echo -e "test home\n"
   rsync -auhvn --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ $dst/home/toshiaki/

else
    echo -e "test \n"
    # echo "backup Documents"
    # rsync -auhvn --progress  $src/Documents/ $dst/Documents/
    echo "backup Pictures"
    rsync -auhvn --progress $src/Pictures/ $dst/Pictures/
    echo "backup Videos"
    rsync -auhvn --progress $src/Videos/ $dst/Videos/
    echo "backup Music"
    rsync -auhvn --progress $src/Music/ $dst/Music/
    # echo "backup home"
    # rsync -auhvn --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ $dst/home/toshiaki/
fi
