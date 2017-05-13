#!/bin/bash
# Usage:
# ./SystemBackup.sh $OUTPUT_PATH
#arg1 output path

#mountOutputPath="/var/systembackup/mountOutput.txt"
rsyncOutputPath=$1
#rsyncOutputPath="/mnt/STORAGE_ee7e0/owncloud_backup"
drive="STORAGE_ee7e0"
date=$(date +\%Y\%m\%d)

#> $mountOutputPath
#mount | grep $drive > $mountOutputPath

echo Checking if $drive is mounted...
#if [ ! -s $mountOutputPath ]
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
rsync -aAxXq --exclude-from=/var/rsync/rsyncExclusions.list /* $rsyncOutputPath/rpicamera_rsync_temp
echo Putting it in a tar...
tar -cvpzf $rsyncOutputPath/$computerName_backup_$date.tar.gz $rsyncOutputPath/rpicamera_rsync_temp
echo Starting server again.
service apache2 start
echo Script is done!
