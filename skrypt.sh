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

initialize_repo() {
  echo "Klonowanie repozytorium..."
  git clone https://github.com/karoljaro/Lab4.git
  if [ $? -eq 0 ]; then
    echo "Repozytorium sklonowane do katalogu Lab4_cloned_repo."
    export PATH="$(pwd)/Lab4_cloned_repo:$PATH"
    echo "Dodano ścieżkę $(pwd)/Lab4_cloned_repo do PATH dla bieżącej sesji."
    echo "Aby zmiany w PATH były trwałe, dodaj powyższą linię 'export PATH...' do swojego pliku konfiguracyjnego powłoki (np. ~/.bashrc)."
  else
    echo "Błąd podczas klonowania repozytorium."
  fi
}

create_error_files() {
  local num_errors=${1:-100} # Domyślnie 100, jeśli argument nie jest podany
  script_name=$(basename "$0")
  current_date=$(date)
  echo "Tworzenie ${num_errors} plików error..."
  for i in $(seq 1 "${num_errors}"); do
    dir_name="error${i}"
    mkdir -p "${dir_name}"
    filename="${dir_name}/error${i}.txt"
    echo "Nazwa pliku: error${i}.txt" > "${filename}"
    echo "Nazwa skryptu: ${script_name}" >> "${filename}"
    echo "Data utworzenia: ${current_date}" >> "${filename}"
    echo "Utworzono plik: ${filename} w katalogu ${dir_name}"
  done
}

show_help() {
  echo "Dostępne flagi:"
  echo "  --date, -d          Wyświetla dzisiejszą datę"
  echo "  --logs [N], -l [N]  Tworzy N plików logx.txt (domyślnie 100)."
  echo "                      N musi być liczbą całkowitą."
  echo "  --error [N], -e [N] Tworzy N katalogów errorx z plikami errorx.txt (domyślnie 100)."
  echo "                      N musi być liczbą całkowitą."
  echo "  --init              Klonuje repozytorium i ustawia ścieżkę w PATH (dla bieżącej sesji)."
  echo "  --help, -h          Wyświetla tę pomoc"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --date | -d)
            show_date
            ;;
         --logs | -l)
            create_logs "$2"
            shift
            ;;
         --init)
            initialize_repo
            ;;
         --error | -e)
            create_error_files "$2"
            ;;
         --help | -h)
            show_help
            ;;
        *)
            echo "Nieznana flaga: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done