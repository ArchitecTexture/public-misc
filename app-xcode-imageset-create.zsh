#!/usr/bin/env zsh

# App development
# Xcode imageset convertor
#
# Created by ArchitecTexture on 2024-08-05
# ArchitecTexture@gmail.com
#
# Use this whe you have an image that you want to use when building an app in
# Xcode. This will create an imageset (i.e., x1, x2, x3).

# Requires: sips
if ! command -v -- "sips" > /dev/null 2>&1; then
    printf >&2 '%s\n' "'sips' is not available."

    exit
fi

if [[ -z "$1" ]]; then
    echo "Xcode Imageset Creator"
    echo
    echo "Run this in the directory where the base image exists."
    echo "Example:"
    echo
    echo "    ${0} <my_file>"
    echo

    exit
fi

my_file=${1}
my_file_base=${my_file:r}

# If the input file is not PNG, then convert it to PNG.
if [[ $(sips -g format "$my_file") == "*png" ]]; then
    echo "File is already PNG format."
else
    echo "Converting to PNG format."
    sips -s format png ${my_file} --out ${my_file_base}.png > /dev/null
fi

echo "Creating 100 px wide version."
sips -Z 100 ${my_file_base}.png --out ${my_file_base}@1x.png > /dev/null

echo "Creating 200 px wide version."
sips -Z 200 ${my_file_base}.png --out ${my_file_base}@2x.png > /dev/null

echo "Creating 500 px wide version."
sips -Z 500 ${my_file_base}.png --out ${my_file_base}@3x.png > /dev/null

echo "Done."
echo

