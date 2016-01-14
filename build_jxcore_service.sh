#!/bin/bash

NORMAL_COLOR='\033[0m'
RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
GRAY_COLOR='\033[0;37m'

LOG() {
  COLOR="$1"
  TEXT="$2"
  echo -e "${COLOR}$TEXT ${NORMAL_COLOR}"
}

CHECK() {
  command -v $1 > /dev/null && [ $? -eq 0 ] || { LOG $RED_COLOR "$1 is required, but it is not installed. Aborting!\n"; exit 1; }
}

if [ $# -eq 2 ]; then
  ANDROID_SDK=$1
  ANDROID_NDK=$2
else
  LOG $RED_COLOR "Function call requires paths to Android SDK and Android NDK\n"; exit 1
fi 

echo "sdk.dir=$ANDROID_SDK" > local.properties
echo "ndk.dir=$ANDROID_NDK" >> local.properties
chmod +x gradlew 
./gradlew build

if [ -d out ]; then
  rm -rf out
fi

mkdir out
find app/build/outputs/apk -type f -not -name '*unaligned*' | xargs -i cp {} out
LOG $GREEN_COLOR "Go to /out and take your files\n"

