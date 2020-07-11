#now let's sync los 16

mkdir los16
cd los16

git config --global user.name ItsVixano
git config --global user.email vixanonew@gmail.com
git config --global color.ui false

repo init -u git://github.com/LineageOS/android.git -b lineage-16.0 --depth=1
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune

#cloning device vendor and kernel tree

git clone https://github.com/GuaiYiHu/android_vendor_xiaomi_whyred-oss --depth=1 -b mkp vendor/xiaomi/whyred
git clone https://github.com/GuaiYiHu/android_kernel_xiaomi_whyred --depth=1 -b mkp-new kernel/xiaomi/whyred
git clone https://github.com/shekhawat2/android_device_xiaomi_whyred-1 --depth=1 -b lineage-16.0 device/xiaomi/whyred

#compiling los

source build/envsetup.sh
breakfast whyred
croot
brunch whyred
