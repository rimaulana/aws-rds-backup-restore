#!/bin/bash

# Database credentials
user=""
password=""
host=""
# db_list=(dba dbb dbc dbd dbe dbf)
db_list=()

# Other options
backup_path="/path/to/backup/folder"
date=$(date +"%d-%b-%Y")

# Set default file permissions
umask 177

for db_name in ${db_list[@]}
do
    echo "Downloading $db_name into $db_name-$date.sql"
    # Dump database into SQL file
    mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/$db_name-$date.sql
    echo "Creating Zip file for $db_name-$date.zip"
    zip $backup_path/$db_name-$date.zip $backup_path/$db_name-$date.sql
    rm $backup_path/$db_name-$date.sql
    echo "Done processing $db_name"
done
