#!/bin/bash
# Usage:
# ./SystemBackup.sh $OUTPUT_PATH
#arg1 output path

rsyncOutputPath=$1
drive="STORAGE_ee7e0"
date=$(date +\%Y\%m\%d)

echo Checking if $drive is mounted...

if ! mount | grep $drive > /dev/null; then
	echo $drive is not mounted. I will give it a shot...
    mount --all
    if ! mount | grep $drive > /dev/null; then
		echo Still cant mount. Check connection... Bye.
        exit
    fi
fi
echo Drive $drive is mounted.
echo Killing server...
service apache2 stop
sleep 10
echo $drive is mounted... Executing rsync command.
rsync -aAxXql --exclude-from=/var/rsync/rsyncExclusions.list /* $rsyncOutputPath/rpicamera_rsync_temp
echo Putting it in a tar...
tar -cvpzf $rsyncOutputPath/rpicamera_backup_$date.tar.gz $rsyncOutputPath/rpicamera_rsync_temp
echo Starting server again.
service apache2 start
echo Script is done!
