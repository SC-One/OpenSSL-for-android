#!/bin/bash
set -e
set -x

# Set directory
#SCRIPTPATH=`realpath .` #MacOS
export ANDROID_NDK_HOME=$1
OPENSSL_DIR=openssl-OpenSSL_1_1_1q

OUTPUT_DIR=output

git clean -f # install git! no time to fix now :/

# Find the toolchain for your build machine
toolchains_path=$(python toolchains_path.py --ndk ${ANDROID_NDK_HOME})

# Configure the OpenSSL environment, refer to NOTES.ANDROID in OPENSSL_DIR
# Set compiler clang, instead of gcc by default
CC=clang

# Add toolchains bin directory to PATH
PATH=$toolchains_path/bin:$PATH

# Set the Android API levels
ANDROID_API=21

# Set the target architecture
# Can be android-arm, android-arm64, android-x86, etc
if [ -z "$2" ]
  then
    architecture=android-arm64
else
    architecture=$2
fi


# Create the make file
cd ${OPENSSL_DIR}
./Configure ${architecture} -D__ANDROID_API__=$ANDROID_API


# Build
make -j$(nproc)

# Copy the outputs
OUTPUT_INCLUDE=${OUTPUT_DIR}/include
OUTPUT_LIB=${OUTPUT_DIR}/lib/${architecture}
rm -rf $OUTPUT_INCLUDE
rm -rf $OUTPUT_LIB
mkdir -p $OUTPUT_INCLUDE
mkdir -p $OUTPUT_LIB
cp -RL include/openssl $OUTPUT_INCLUDE
cp libcrypto.so $OUTPUT_LIB
cp libcrypto.a $OUTPUT_LIB
cp libssl.so $OUTPUT_LIB
cp libssl.a $OUTPUT_LIB
