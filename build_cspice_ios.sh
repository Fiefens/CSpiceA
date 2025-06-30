#!/bin/bash

set -e

SRC_DIR="cspice/source"
INC_DIR="cspice/include"
BUILD_DIR="build/arm64"
OUT_DIR="output"
OUTPUT="$OUT_DIR/libcspice_ios_arm64.a"

mkdir -p $BUILD_DIR
mkdir -p $OUT_DIR

echo "Compiling all .c files for iOS arm64..."

for file in $SRC_DIR/*.c; do
  filename=$(basename "$file")

  # Skip CLI tools or non-library files
  case "$filename" in
    brief.c|ckbrief.c|inspekt.c|spacit.c|mkspk.c|mkpc.c|chronos.c|dafun.c|mkpd.c|mkpcs.c|msopck.c|subpt.c|subslr.c)
      echo "Skipping $filename (not part of core library)"
      continue
      ;;
  esac

  clang -arch arm64 \
    -isysroot $(xcrun --sdk iphoneos --show-sdk-path) \
    -I$INC_DIR \
    -c "$file" -o "$BUILD_DIR/$(basename "${file%.c}.o")"
done


echo "Creating static library..."
libtool -static -o $OUTPUT $BUILD_DIR/*.o

echo "✅ Static library created at $OUTPUT"
