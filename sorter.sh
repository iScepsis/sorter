#!/bin/bash


source bin/file_types
source bin/functions/check_directory
source bin/functions/get_file_type_index
source bin/functions/create_output_directory

export CURRENT_FILE_TYPE=""
export SORTING_PATH=$HOME/Documents/LM
export OUTPUT_DIR=$SORTING_PATH/Sorted
export FILE_TYPE_INDEX=""

#check_directory
echo ${target_directories[0]}
echo ${mime_types[1]}

while getopts u:d:p:f: option
do
    case "${option}"
    in
        p) SORTING_PATH=$OPTARG;;
        d) OUTPUT_DIR=$OPTARG;;
    esac
done

echo "Current sorting path: $SORTING_PATH"
echo "::::::::::::::::START SORTING:::::::::::::::"

create_output_directory

for file in $SORTING_PATH/*
do
    #if [[ -d $file ]] ; then
    #    echo "$file is directory"
    #fi
    if [[ -f $file ]] ; then
        CURRENT_FILE_TYPE=$(file -b --mime-type "$file")
        check_directory
        get_file_type_index
        #echo $CURRENT_FILE_TYPE

    fi
done

echo "::::::::::::::SORTING IS FINISH::::::::::::"
