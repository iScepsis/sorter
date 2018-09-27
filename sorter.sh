#!/bin/bash

source bin/mime_types_list
source bin/target_directories_list
source bin/functions/check_directory
source bin/functions/get_file_type_index
source bin/functions/create_output_directory

v_current_file_type=""       #переменная для хранения текущего типа файла
v_sorting_path=$HOME/Documents/tests      #директория, в которой будем сортировать файлы
v_output_dir=$v_sorting_path/Sorted         #директория, куда будем складывать отсортированные файлы
v_file_type_index=""            #Текущий индекс для обрабатываемого файла
v_dest_path=""
v_sort_type="move"
file_handled_count=0

#Читаем опции запуска скрипта
while getopts u:d:p:f: option
do
    case "${option}"
    in
        p) v_sorting_path=$OPTARG;;
        d) v_output_dir=$OPTARG;;
        c) v_sort_type="cp"
    esac
done

echo "Current sorting path: $v_sorting_path"
echo "::::::::::::::::START SORTING:::::::::::::::"

#Создаем директорию в которую будем перемещать/копировать файлы
create_output_directory

for file in $v_sorting_path/*
do
    #if [[ -d $file ]] ; then
    #    echo "$file is directory"
    #fi
    if [[ -f $file ]] ; then
        v_current_file_type=$(file -b --mime-type "$file")
        #Получаем индекс типа файла из массивов в bin/file_types
        get_file_type_index

        #Проверяем, существует ли директория куда будем перемещать файл и если нет, создаем ее
        check_directory

        case $v_sort_type
        in
            copy) cp "$file" "$v_dest_path";;
            move) mv "$file" "$v_dest_path";;
        esac

      #  if [[ $v_sort_type == "copy" ]]; then
      #      cp "$file" "$v_dest_path"
      #  else
      #     mv "$file" "$v_dest_path"
      #  fi

        if [ "$?" -eq "0" ]; then
            ((file_handled_count++))
        fi

    fi
done

echo "$file_handled_count files has been $v_sort_type"

echo "::::::::::::::SORTING IS FINISH::::::::::::"
