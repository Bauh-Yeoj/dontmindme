#now let's sync ReloadedOS Q source

mkdir reloaded
cd reloaded

git config --global user.name ItsVixano
git config --global user.email vixanonew@gmail.com
git config --global color.ui false

repo init -u https://github.com/ReloadedOS/android_manifest.git -b q --depth=1
repo sync -j$( nproc --all ) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune

# Cloning hals

git clone --depth=1 https://github.com/ThankYouMario/proprietary_vendor_qcom_common.git vendor/qcom/common && git clone --depth=1 https://github.com/AOSPA/android_hardware_qcom_display.git -b quartz-8998 hardware/qcom/display && git clone --depth=1 https://github.com/AOSPA/android_hardware_qcom_audio.git -b quartz-8998 vendor/qcom/opensource/audio-hal/primary-hal && git clone --depth=1 https://github.com/AOSPA/android_hardware_qcom_media.git -b quartz-8998 hardware/qcom/media && git clone --depth=1 -b lineage-17.1-legacy-um https://github.com/LineageOS/android_device_qcom_sepolicy device/qcom/sepolicy-legacy-um && rm -rf packages/apps/Bluetooth && git clone --depth=1 https://github.com/AOSPA/android_packages_apps_Bluetooth -b quartz-dev packages/apps/Bluetooth && rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr && git clone --depth=1 https://github.com/LineageOS/android_vendor_qcom_opensource_data-ipa-cfg-mgr vendor/qcom/opensource/data-ipa-cfg-mgr

# Cloning dt vt and kernel

git clone --depth=1 https://github.com/ItsVixano/device_xiaomi_whyred device/xiaomi/whyred -b wip2
git clone --depth=1 https://github.com/ItsVixano/vendor_xiaomi_whyred vendor/xiaomi/whyred
git clone --depth=1 https://github.com/sreekfreak995/kranul -b eas-new-cam kernel/xiaomi/whyred

# compiling reloaded

. build/envsetup.sh
lunch reloaded_whyred-userdebug
make reloaded -j1

# pushing on

export BUILDFILE=$(find $(pwd)/out/target/product/whyred/Reloaded*-whyred.zip
curl --upload-file $BUILDFILE https://transfer.sh/
exit
