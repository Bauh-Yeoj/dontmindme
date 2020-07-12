# Building script for bluid

mkdir fluid
cd fluid

git config --global user.name ender1324
git config --global user.email ender1324@abv.bg
git config --global color.ui false

# Sync bluidOS
repo init -u https://github.com/Project-Fluid/manifest.git -b fluid-10 --depth=1
repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc --all)

# Cloning device sources
git clone https://github.com/ender1324/android_device_oneplus_bacon -b fluid-10 device/oneplus/bacon
git clone https://github.com/Feinzer/android_kernel_oneplus_msm8974 -b ten --depth=1 kernel/oneplus/msm8974
git clone https://github.com/bacon-dev/android_vendor_oneplus -b ten vendor/oneplus
git clone https://github.com/bacon-dev/prebuilts_gcc_linux-x86_arm_arm-eabi-linaro-7 --depth=1 prebuilts/gcc/linux-x86/arm/arm-eabi-linaro-7

# Compiling BluidOS
. build/envsetup.sh
brunch bacon

# Upload the build
export BUILDFILE=$(find $(pwd)/out/target/product/bacon/FluidOS-*.zip
curl --upload-file $BUILDFILE https://transfer.sh/
exit
