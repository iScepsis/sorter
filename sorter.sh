#!/bin/bash

source bin/file_types
source bin/functions/check_directory
source bin/functions/get_file_type_index
source bin/functions/create_output_directory

v_current_file_type=""
v_sorting_path=$HOME/Documents/LM
v_output_dir=$v_sorting_path/Sorted
v_file_type_index=""

#check_directory
echo ${target_directories[0]}
echo ${mime_types[1]}

while getopts u:d:p:f: option
do
    case "${option}"
    in
        p) v_sorting_path=$OPTARG;;
        d) v_output_dir=$OPTARG;;
    esac
done

echo "Current sorting path: $v_sorting_path"
echo "::::::::::::::::START SORTING:::::::::::::::"

create_output_directory

for file in $v_sorting_path/*
do
    #if [[ -d $file ]] ; then
    #    echo "$file is directory"
    #fi
    if [[ -f $file ]] ; then
        v_current_file_type=$(file -b --mime-type "$file")
        check_directory
        get_file_type_index
        #echo $CURRENT_FILE_TYPE

    fi
done

echo "::::::::::::::SORTING IS FINISH::::::::::::"
