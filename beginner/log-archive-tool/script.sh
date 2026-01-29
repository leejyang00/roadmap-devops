#!/bin/bash

read -p "Enter log directory: " DIRECTORY
# /var/log

echo "$DIRECTORY"

DATE=$(date +'%Y%m%d')
echo $DATE

TIME=$(date +'%H%M%S')
echo $TIME

FILENAME=logs_archive_${DATE}_${TIME}.tar.gz
echo $FILENAME

tar -czvf $FILENAME $DIRECTORY
