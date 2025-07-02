#!/bin/bash

set -e

SRC_DIR="cspice/source"
INC_DIR="cspice/include"
BUILD_DIR="build/arm64"
OUT_DIR="output"
OUTPUT="$OUT_DIR/libcspice_ios_arm64.a"

mkdir -p $BUILD_DIR
mkdir -p $OUT_DIR

echo "Compiling core CSpice .c files for iOS arm64..."

for file in $SRC_DIR/*.c; do
  filename=$(basename "$file")

  # Skip files with a main() function or problematic platform-specific sources
  if grep -qE '^\s*(int|void)?\s*main\s*\(.*\)' "$file" || [[ "$filename" == "close.c" ]]; then
    echo "Skipping $filename (contains main() or is not iOS-compatible)"
    continue
  fi

  clang -arch arm64 \
    -isysroot $(xcrun --sdk iphoneos --show-sdk-path) \
    -I$INC_DIR \
    -c "$file" -o "$BUILD_DIR/$(basename "${file%.c}.o")"
done

echo "Creating static library..."
libtool -static -o $OUTPUT $BUILD_DIR/*.o

echo "Static library created at $OUTPUT"
