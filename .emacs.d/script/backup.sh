#!/bin/bash



if [ "$1" == "all" ]
then

    echo "backup Documents"
    rsync -auhv --progress  /mnt/sdc/frenz/Documents/ /mnt/sdb/Documents/
    echo "backup Pictures"
    rsync -auhv --progress /mnt/sdc/frenz/Pictures/ /mnt/sdb/Pictures/
    echo "backup Videos"
    rsync -auhv --progress /mnt/sdc/frenz/Videos/ /mnt/sdb/Videos/
    echo "backup Music"
    rsync -auhv --progress /mnt/sdc/frenz/Music/ /mnt/sdb/Music/
    echo "backup home"
    rsync -auhv --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ /mnt/sdb/home/toshiaki/

elif [ "$1" == "delete" ]
then
    # echo "backup Documents"
    # rsync -auhv --progress --delete  /mnt/sdc/frenz/Documents/ /mnt/sdb/Documents/
    echo "backup Pictures"
    rsync -auhv --progress --delete /mnt/sdc/frenz/Pictures/ /mnt/sdb/Pictures/
    echo "backup Videos"
    rsync -auhv --progress --delete /mnt/sdc/frenz/Videos/ /mnt/sdb/Videos/
    echo "backup Music"
    rsync -auhv --progress --delete /mnt/sdc/frenz/Music/ /mnt/sdb/Music/
    # echo "backup home"
    # rsync -auhv --progress --delete --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ /mnt/sdb/home/toshiaki/

elif [ "$1" == "documents" ]
then
     echo "backup Documents"
     rsync -auhvn --progress  /mnt/sdc/frenz/Documents/ /mnt/sdb/Documents/

elif [ "$1" == "home" ]
then
     echo "backup home"
     rsync -auhvn --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/ --exclude=  /home/toshiaki/ /mnt/sdb/home/toshiaki/

else
    echo -e "test \n"
    # echo "backup Documents"
    # rsync -auhvn --progress  /mnt/sdc/frenz/Documents/ /mnt/sdb/Documents/
    echo "backup Pictures"
    rsync -auhvn --progress /mnt/sdc/frenz/Pictures/ /mnt/sdb/Pictures/
    echo "backup Videos"
    rsync -auhvn --progress /mnt/sdc/frenz/Videos/ /mnt/sdb/Videos/
    echo "backup Music"
    rsync -auhvn --progress /mnt/sdc/frenz/Music/ /mnt/sdb/Music/
    # echo "backup home"
    # rsync -auhvn --progress --exclude=.cache/ --exclude=projects/dotfiles/.config/google-chrome-unstable/  /home/toshiaki/ /mnt/sdb/home/toshiaki/
fi
