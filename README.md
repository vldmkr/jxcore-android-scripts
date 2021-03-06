#### Set environment variables
```sh
export ANDROID_SDK=<path to your Android Sdk like ~/home/Android/Sdk>
export ANDROID_NDK=<path to your Android Ndk like $ANDROID_SDK/ndk-bundle>
```

#### Building jxcore
For more information see [How to Compile](https://github.com/jxcore/jxcore/blob/master/doc/Android_Compile.md) document.

```sh
git clone https://github.com/jxcore/jxcore.git
jxcore/build_scripts/android-configure.sh $ANDROID_NDK
jxcore/build_scripts/android_compile.sh $ANDROID_NDK
```

##### ARM64

By default build script (SM - static library) doesn't compile for ARM64. In order to enable it, edit build_scripts/android_compile.sh file:

replace
```sh
ARM64=0 #out_arm64_droid
```
to 
```sh
ARM64=out_arm64_droid
```

#### Building jxcore-cordova binaries
For more information see [Updating JXcore binaries](https://github.com/jxcore/jxcore-cordova#updating-jxcore-binaries-optional) document.

Clone jxcore-cordova repository:
```sh
git clone https://github.com/jxcore/jxcore-cordova.git
```
Refresh `jxcore-cordova/src/android/jxcore-binaries` folder contents:
```sh
cp -f /jxcore/out_android/android/bin/* jxcore-cordova/src/android/jxcore-binaries/
```
Recompile .so files
```sh
(cd jxcore-cordova-master/src/android/jni; $ANDROID_NDK/ndk-build) 
```
Get your binaries from `jxcore-cordova/src/android/libs`

##### ARM64

Update makefiles:
```sh
cp Application.mk Android.mk jxcore-cordova/src/android/jni/
```
Then refresh jxcore binaries and recompile .so files.

#### Installing libjxcore.so
```sh
adb remount
adb push jxcore-cordova-master/src/android/libs/armeabi-v7a/libjxcore.so /vendor/lib
```

#### Getting jxcore service
```sh
get_jxcore_bin.sh $ANDROID_SDK
```

#### Building APK

Copy `build_jxcore_service.sh` to your project folder.
```sh
build_jxcore_service.sh $ANDROID_SDK $ANDROID_NDK <X.Y.Z>
```
#### JS here:
```
<app-name>/app/src/main/assets/www/jxcore/
```
#### JS - Java bindings are in the jxcore_module.js file.

### jxcore ARM64 fixes
#### libuv fixes
[Android 5.0 does not have pthread_cond_timedwait_monotonic_np](https://github.com/libuv/libuv/issues/172)

[The corresponding commit](https://github.com/ljbade/libuv-1/commit/a23d5b4f7a0f803e23ff9df6a57ee416d9b31610)

This feature is implemented at `deps/uv/src/unix/thread.c'

#### cares fixes
[API to get android system properties is removed in arm64 platforms](http://stackoverflow.com/questions/28413530/api-to-get-android-system-properties-is-removed-in-arm64-platforms)

This feature is implemented at `jxcore-android-scripts/deps/cares/src/android_api21.h` and included in `jxcore-android-scripts/deps/cares/src/ares_init.c`

