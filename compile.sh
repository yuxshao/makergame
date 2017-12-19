#!/bin/sh
# set -x
set -e
directory="$(dirname "${BASH_SOURCE[0]}")"
file=$(basename "$1" .mg)
echo "Running MakerGame compiler on $file.mg"
export MAKERGAME_PATH="$directory/lib"
$($directory/makergame.native < $1 > $file.ll)
echo "Running LLVM Compiler on $file.ll"
$(llc -relocation-model=pic $file.ll)
echo "Linking $file.s with runtime"
$(cc $file.s -o $file.exe -L$directory/runtime -lmakergame -lm -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++)
echo "Done."

