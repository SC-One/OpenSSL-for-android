#!/bin/bash
chmod +x common.sh
 # android-arm android-arm64 android-x86 android-x86 etc.
for VARIABLE in android-arm android-arm64 android-x86 android-x86
do
    ./common.sh $1 $VARIABLE 
done
