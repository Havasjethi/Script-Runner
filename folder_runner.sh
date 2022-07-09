#!/bin/bash

ls='/bin/ls -1'

folder_to_read=$1
after_finish=$2

# folder_to_read=/home/havas/Documents/Projects/_custom_shutdown/script_folder

if [[ ! -e $folder_to_read ]]; then
  echo "Given folder: '$folder_to_read' not exists";
  exit 1
fi


make_it_modifyable() {
  local file=$1
  if [[ ! (-x $file) ]]; then
      echo "Change '$file' to be executeable"
      chmod +x $file
  fi
}

execute_function() {
  local file=$1
  echo -e "\t[$2\\$3] -- Execute $file"
  bash $file
}

coolprinter() {
  echo "--- $1"
}

main () {
  echo "--- Start execution ---"
  local files=$($ls $folder_to_read);
  local total="$($ls $folder_to_read | wc -l)";
  local current_index=1;

  coolprinter "[] Found $total scripts to exectue"

  for file_name in $files ; do
    file="$folder_to_read/$file_name"
    make_it_modifyable $file
    execute_function $file $current_index $total
    current_index=$(($current_index+1))
  done

  coolprinter '--- Scripts finished ---'

  $after_finish
}

main
