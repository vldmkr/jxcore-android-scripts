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

if [ $# -eq 1 ]; then
  ANDROID_SDK=$1
else
  LOG $RED_COLOR "Function call requires path to Android SDK\n"; exit 1
fi 

CHECK git

if [ -d jxcore-android-service ]; then
  rm -rf jxcore-android-service
fi
git clone https://github.com/vldmkr/jxcore-android-service.git

echo "sdk.dir=$ANDROID_SDK" > jxcore-android-service/jxcore-service/local.properties
chmod +x jxcore-android-service/jxcore-service/gradlew 
(cd jxcore-android-service/jxcore-service; ./gradlew install)
