#!/bin/sh
set -e
directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$(dirname "$1")"
file=$(basename "$1" .mg)
echo "Running MakerGame compiler on $file.mg"
export MAKERGAME_PATH="$directory/lib"
$($directory/makergame.native < $file.mg > $file.ll)
echo "Running LLVM Compiler on $file.ll"
$(llc -relocation-model=pic $file.ll)
echo "Linking $file.s with runtime"
$(cc $file.s -o $file.exe -L$directory/runtime -lmakergame -lm -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system -lstdc++)
echo "Done."

