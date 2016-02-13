#!/bin/bash

if ! [ -f $1 ]; then
    echo "$1 file not found"
    exit 0
fi

dir=$(dirname $1)
filename="${1##*/}"
extension="${filename##*.}"
filebasename="${filename%.*}"

if [ $extension == "cpp" ]; then
    g++ "$dir/$filename" -o "$dir/$filebasename.o" -std=c++11 -Wall && "$dir/$filebasename.o"
    rm -f "$dir/$filebasename.o"
else
    echo "No support for .$extension files"
fi

