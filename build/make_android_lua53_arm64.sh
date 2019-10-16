if [ -n "$ANDROID_NDK" ]; then
    export NDK=${ANDROID_NDK}
elif [ -n "$ANDROID_NDK_HOME" ]; then
    export NDK=${ANDROID_NDK_HOME}
else
    export NDK=~/android-ndk-r16b
fi

function build() {
    API=$1
    ABI=$2
    TOOLCHAIN_ANME=$3
    BUILD_PATH=build.${ABI}
    cmake -H. -B${BUILD_PATH} -DCMAKE_TOOLCHAIN_FILE=${NDK}/build/cmake/android.toolchain.cmake -DANDROID_NATIVE_API_LEVEL=${API} -DANDROID_TOOLCHAIN_NAME=${TOOLCHAIN_ANME}
    cmake --build ${BUILD_PATH} --config Release
    mkdir -p plugin_lua53/Plugins/Android/libs/${ABI}/
    cp ${BUILD_PATH}/libxlua.so plugin_lua53/Plugins/Android/libs/${ABI}/libxlua.so
}

build android-16 arm64-v8a aarch64-linux-android-4.9
build android-16 armeabi-v7a arm-linux-androideabi-4.9
build android-16 x86 x86-4.9
