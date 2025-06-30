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
# Directly compile without cd'ing into build
clang -arch arm64 \
  -isysroot $(xcrun --sdk iphoneos --show-sdk-path) \
  -I$INC_DIR \
  -c $SRC_DIR/*.c \
  -o $BUILD_DIR/temp.o

# Combine all .o files
echo "Creating static library..."
libtool -static -o $OUTPUT $BUILD_DIR/*.o

echo "✅ Static library created at $OUTPUT"
