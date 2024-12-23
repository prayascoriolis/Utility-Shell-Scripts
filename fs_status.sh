#!/bin/bash

# Set the threshold for low disk space (in percentage)
DISK_THRESHOLD=20

# Get the detailed disk usage information for all filesystems
DISK_DETAILS=$(df -H | egrep -v "Filesystem|tmpfs" | awk '{print $1 "   " $5}' | tr -d '%')

# Send email with the disk space usage details
echo -e "Disk space is being checked. Here are the current disk usage details:\n\nFileSystem     Usage % \n$DISK_DETAILS" | mail -s "Disk Space Check" $TO

# Check disk space usage for every disk and send an email if usage is greater than or equal to the threshold
df -H | egrep -v "Filesystem|tmpfs" | while read line; do
    # Extract the filesystem name and usage percentage
    FILESYSTEM=$(echo $line | awk '{print $1}')
    USAGE=$(echo $line | awk '{print $5}' | tr -d '%')

    # If disk usage is greater than or equal to the threshold, send a warning email
    if [[ $USAGE -ge $DISK_THRESHOLD ]]; then
        echo "WARNING: Disk usage on $FILESYSTEM is high: $USAGE%." | mail -s "Disk Space Alert: $FILESYSTEM" $TO
    fi
done

