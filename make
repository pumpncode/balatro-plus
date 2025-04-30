#!/bin/bash

# Make a release version for added to github release

shopt -s extglob

OUT=release
if [ -n "$1" ]; then
  OUT="$1"
fi

if [ -d "./$OUT" ]; then
  rm -fr "./$OUT"
fi

mkdir $OUT
mkdir $OUT/assets
cp -r ./assets/!(collection.png) $OUT/assets/
cp -r ./localization $OUT/
cp -r ./lovely $OUT/
cp -r ./src $OUT/
cp ./balatro-plus.json $OUT/
cp ./config.lua $OUT/
