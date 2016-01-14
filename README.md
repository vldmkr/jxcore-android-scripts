## Set environment variables
```sh
export ANDROID_SDK=<path to your Android Sdk like ~/home/Android/Sdk>
export ANDROID_NDK=<path to your Android Ndk like $ANDROID_SDK/ndk-bundle>
```

## Building jxcore
```sh
git clone https://github.com/jxcore/jxcore.git
jxcore/build_scripts/android-configure.sh $ANDROID_NDK
jxcore/build_scripts/android_compile.sh $ANDROID_NDK
```

## Building jxcore cordova core
```sh
git clone https://github.com/jxcore/jxcore-cordova.git
cp -f /jxcore/out_android/android/bin/* jxcore-cordova/src/android/jxcore-binaries/
(cd jxcore-cordova-master/src/android/jni; $ANDROID_NDK/ndk-build) 
```

## Installing libjxcore.so
```sh
adb remount
adb push jxcore-cordova-master/src/android/libs/armeabi-v7a/libjxcore.so /vendor/lib
```

## Getting jxcore service
```sh
get_jxcore_bin.sh $ANDROID_SDK
```

## Building APK
```sh
build_jxcore_service.sh $ANDROID_SDK $ANDROID_NDK
```
## JS here:
```
strem-engine/app/src/main/assets/www/jxcore/
