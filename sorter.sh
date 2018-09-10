#!/bin/bash


source bin/file_types
source bin/functions/check_directory

export CURRENT_FILE_TYPE="txt"

#check_directory
echo ${target_directories[0]}
echo ${mime_types[1]}

for file in ~/Documents/*
do
    echo "$file"
done
