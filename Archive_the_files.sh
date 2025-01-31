#!/bin/bash

# Description: Identify files larger than 500MB or older than 6 months.
# Compress them and move the compressed archive file to an "archive" folder.

# Variables
DIR_PATH="/home/sarvesh/myscript"  # Absolute path to the directory
DAYS=180  # 6 months (approx. 180 days)
DEPTH=1  # Restrict search to the current directory only
ARCHIVE_DIR="$DIR_PATH/archive"  # Path to the archive folder

# Check if the directory exists
if [[ ! -d "$DIR_PATH" ]]; then
    echo -e "\e[31mDirectory does not exist: $DIR_PATH\e[0m"
    exit 1
fi

# Check if the 'archive' folder exists, create it if not
if [[ ! -d "$ARCHIVE_DIR" ]]; then
    mkdir -p "$ARCHIVE_DIR"
    echo -e "\e[32mArchive folder created: $ARCHIVE_DIR\e[0m"
fi

# Find files larger than 240MB or older than 6 months and compress each one individually
for i in find "$DIR_PATH" -maxdepth $DEPTH \(-type f -size +500 -o -mtime +$DAYS \) 
do
	if [[ $RUN -eq 0 ]]
	then
		echo "working"
		gzip $i || exit 1
		mv $i.gz $ARCHIVE_DIR || exit 1
	fi
done

