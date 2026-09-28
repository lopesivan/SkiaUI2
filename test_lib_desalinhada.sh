#!/usr/bin/env bash

ANDROID_NDK_HOME=/home/ivan/Android/Sdk/ndk/29.0.14206865
READELF="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-readelf"

rm -rf /tmp/apk-so
mkdir -p /tmp/apk-so

unzip -q \
    app/build/outputs/apk/debug/app-debug.apk \
    'lib/arm64-v8a/*.so' \
    -d /tmp/apk-so

for so in /tmp/apk-so/lib/arm64-v8a/*.so; do
    echo
    echo "===== $(basename "$so") ====="
    "$READELF" -lW "$so" | grep LOAD
done

exit 0
