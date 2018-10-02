#!/bin/bash

source bin/mime_types_list
source bin/target_directories_list
source bin/functions/check_directory
source bin/functions/get_file_type_index
source bin/functions/create_output_directory

v_current_file_type=""          #переменная для хранения текущего типа файла
v_sorting_path=$HOME/Documents/tests      #директория, в которой будем сортировать файлы
v_output_dir=$v_sorting_path/Sorted       #директория, куда будем складывать отсортированные файлы
v_file_type_index=""            #Текущий индекс для обрабатываемого файла
v_dest_path=""                  #Переменная в которую собирается путь до конечной директории, куда будет перемещен файл
v_sort_type="move"              #Режим перемещиния фалов (copy или move)
file_handled_count=0            #Общее кол-во успешно перемещенных файлов
show_info=0


#Читаем опции запуска скрипта
while getopts f:t:c:i option
do
    case "${option}"
    in
        f) v_sorting_path=$OPTARG;; #директория откуда берем файлы
        t) v_output_dir=$OPTARG;;   #директория куда помещаем файлы
        c) v_sort_type=$OPTARG;;    #режим: копирование или перемещение
        i) show_info=$OPTARG;;      #вывод подробной информации
    esac
done

echo "Current sorting path: $v_sorting_path"
echo "::::::::::::::::START SORTING:::::::::::::::"

#Создаем директорию в которую будем перемещать/копировать файлы
create_output_directory

for file in $v_sorting_path/*
do
    if [[ -f $file ]] ; then
        v_current_file_type=$(file -b --mime-type "$file")
        #Получаем индекс типа файла из массивов в bin/file_types
        get_file_type_index

        #формируем и создаем директорию в которую будем помещать файлы
        check_directory

        if [ "$show_info" != 0 ]; then
            echo "File '$file'. Sort type: '$v_sort_type'. To: '$v_dest_path'. Mime-type: '$v_current_file_type'"
        fi

        case $v_sort_type
        in
            copy) cp "$file" "$v_dest_path";;
            move) mv "$file" "$v_dest_path";;
        esac

        if [ "$?" -eq "0" ]; then
            ((file_handled_count++))
        fi

    fi
done

echo "$file_handled_count files has been $v_sort_type"

echo "::::::::::::::SORTING IS FINISH::::::::::::"
