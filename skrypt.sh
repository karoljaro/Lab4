#!/bin/bash

show_date() {
  date
}

create_logs() {
  local num_files=${1:-100} # Domyślnie 100, jeśli argument nie jest podany
  script_name=$(basename "$0")
  current_date=$(date)
  echo "Tworzenie ${num_files} plików log..."
  for i in $(seq 1 "${num_files}"); do
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
            create_logs "$2"
            shift
            ;;
        *)
            echo "Nieznana flaga: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done