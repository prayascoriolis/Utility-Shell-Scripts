#!/bin/bash

# Initialize the email content variable
EMAIL_CONTENT=""

# Get the total available free RAM in megabytes
FREE_SPACE=$(free -mt | grep "Total" | awk '{print $4}')

# Set threshold for low RAM (in MB)
TH=500

# Add RAM status to the email content
if [[ $FREE_SPACE -lt $TH ]]; then
    EMAIL_CONTENT+="WARNING: RAM is running low! Only $FREE_SPACE MB left.\n\n"
else
    EMAIL_CONTENT+="RAM Space is sufficient: $FREE_SPACE MB available.\n\n"
fi

# Set the threshold for low disk space (in percentage)
DISK_THRESHOLD=20

# Get the detailed disk usage information for all filesystems
DISK_DETAILS=$(df -H | egrep -v "Filesystem|tmpfs" | awk '{print $1 "   " $5}')

# Add disk space details to the email content
EMAIL_CONTENT+="Disk space is being checked. Here are the current disk usage details:\n\n"
EMAIL_CONTENT+="FileSystem     Usage %\n$DISK_DETAILS\n\n"

# Check disk space usage for every disk and add a warning if usage is greater than or equal to the threshold
while read line;
do
    # Extract the filesystem name and usage percentage
    FILESYSTEM=$(echo $line | awk '{print $1}')
    USAGE=$(echo $line | awk '{print $5}' | tr -d '%')
    # If disk usage is greater than or equal to the threshold, add a warning to the email content
    if [[ $USAGE -ge $DISK_THRESHOLD ]];
    then
        EMAIL_STR="WARNING: Disk usage on $FILESYSTEM is high: $USAGE%.\n"
        EMAIL_CONTENT="${EMAIL_CONTENT}${EMAIL_STR}"
    fi
done <<< $(df -H | egrep -v "Filesystem|tmpfs")

# Set recipient email for alerts
TO="prayasshutter7@gmail.com"

# Send a single email with all collected information
echo -e "$EMAIL_CONTENT" | mail -s "System Resource Check" $TO
