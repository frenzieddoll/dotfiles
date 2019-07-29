#!/bin/bash

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
