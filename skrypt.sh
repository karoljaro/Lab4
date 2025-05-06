#!/bin/bash

show_date() {
  date
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --date)
            show_date
            ;;
        *)
            echo "Nieznana flaga: $1"
            show_help
            exit 1
            ;;
    esac
    shift
done