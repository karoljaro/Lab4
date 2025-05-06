#!/bin/bash

show_date() {
  date
}

create_logs() {
  script_name=$(basename "$0")
  current_date=$(date)
  for i in $(seq 1 100); do
    filename="log${i}.txt"
    echo "Nazwa pliku: ${filename}" > "${filename}"
    echo "Nazwa skryptu: ${script_name}" >> "${filename}"
    echo "Data utworzenia: ${current_date}" >> "${filename}"
    echo "Utworzono plik: ${filename}"
  done
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --date)
            show_date
            ;;
         --logs)
            create_logs
            ;;
        *)
            echo "Nieznana flaga: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done