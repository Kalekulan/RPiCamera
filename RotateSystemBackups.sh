#!/bin/bash
# Usage:
# ./RotateSystemBackups.sh "rpicamera_backup_20*" "/mnt/STORAGE_ee7e0/rpicamera_backup/"
#arg1 filename pattern
#arg2 output path


Delete() {
    outPath = "/var/systembackup"
    > $outPath/fileList.txt
    ls -drt $1/$2 > $outPath/fileList.txt
    numberOfFiles = $(grep -c / $outPath/fileList.txt)
    if [ $numberOfFiles -gt 5 ]
    then
        echo More than 5 backups. Deleting the oldest files...
        numFilesToDelete = $(($numberOfFiles - 5))
        for ((i = 1; i <= numFilesToDelete; i++))
        {
            firstEntry = $(awk 'NR == n' n=$i $outPath/fileList.txt)
            rm $firstEntry
        }
    else
        echo Nothing to delete.
    fi

}

path = $2
filenamePattern = $1
Delete $path $filenamePattern
exit
