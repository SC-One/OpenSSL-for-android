#!/bin/bash
chmod +x common.sh
 # android-arm android-arm64 android-x86 android-x86_64 etc(I dont know maybe: armeabi-v7a , arm64-v8a , ...).
for VARIABLE in android-arm android-arm64 android-x86 android-x86_64
do
    ./common.sh $1 $VARIABLE $2
done
