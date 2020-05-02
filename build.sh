# Set info vars.
CURRENT_DATE=$(date +'%Y%m%d')
KERNEL_VERSION="[3.18.140]"
ANDROID_VERSION="[P/9-Q/10]"
FILE_NAME="HM4A-GoGreenExt.Kernel-VER.${KERNEL_VERSION}-${ANDROID_VERSION}-${CURRENT_DATE}.zip"

# Delete old stuff.
#rm ~/CAF/AnyKernel2/*.zip
#if [ -f ~/CAF/AnyKernel2/modules/system/lib/modules/wlan.ko ]; then
#    rm ~/CAF/AnyKernel2/modules/system/lib/modules/wlan.ko
#fi

# Start building anykernel zip.
cp ./arch/arm64/boot/Image.gz-dtb ~/AnyKernel3/zImage
#find . -type f -name "wlan.ko" -exec cp -fv {} ~/CAF/AnyKernel2/modules/system/lib/modules/. \;

# Update kernel version
sed -i -e "/KERNEL_VERSION/$KERNEL_VERSION/" ~/AnyKernel3/anykernel.sh
sed -i -e "/ANDROID_VERSION/$ANDROID_VERSION/" ~/AnyKernel3/anykernel.sh

# Zip it!.
pushd ~/AnyKernel3
zip -r9 ${FILE_NAME} * -x build.sh 
popd

# Print final result in color!
GREEN='\033[0;32m'
echo ""
echo -e "${GREEN}> Succeed!, file located at ~/AnyKernel3/$FILE_NAME"
