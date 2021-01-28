# Building script for LOS "the best gaming rom"

mkdir los
cd los

git config --global user.name Bauh-Yeoj
git config --global user.email Devolutiony@yandex.com
git config --global color.ui false

# Sync LOS THE BAST 
python3 ~/bin/repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
python3 ~/bin/repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc --all)

# Cloning device sources
git clone https://github.com/Bauh-Yeoj/kranul --single-branch --depth=1 kernel/xiaomi/whyred
git clone https://github.com/ItsVixano/android_device_xiaomi_whyred --single-branch -b ten-wip --depth=1 device/xiaomi/whyred
git clone https://github.com/ItsVixano/android_vendor_xiaomi_whyred --single-branch -b ten-wip --depth=1 vendor/xiaomi/whyred

# Compiling LOS THE GAMING ROM
rm -rf .repo
source build/envsetup.sh
make clean
lunch lineage_whyred-user
mka bacon -j$(nproc --all)

# Upload the build
ZIP=$(echo out/target/product/whyred/lineage-17.1*.zip)
echo $ZIP
curl --upload-file "$ZIP" http://transfer.sh/
exit
