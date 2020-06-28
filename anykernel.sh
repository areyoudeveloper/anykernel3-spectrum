# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Kernel by Darkness v[3.18.140]
do.devicecheck=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=rolex
device.name2=ido	
device.name3=land
device.name4=santoni
device.name5=riva
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin/*;
chmod +x $ramdisk/sbin/spa;
chown -R root:root $ramdisk/*;

ui_print "This kernel supports Spectrum performance profiles select one by downloading the app or live with the default.";
ui_print "By Tea Everything is Tea";
## AnyKernel install
dump_boot;

# begin ramdisk changes


#remove old spectrum profile
rm -rf $overlay/init.spectrum.rc

# Spectrum Support
backup_file init.rc;
grep "import /init.spectrum.rc" init.rc >/dev/null || sed -i '1,/.*import.*/s/.*import.*/import \/init.spectrum.rc\n&/' init.rc
insert_line init.rc "init.optimkang.sh" after "import /init.spectrum.rc" "exec u:r:init:s0 -- /init.optimkang.sh";

# init.qcom.rc
#backup_file init.qcom.rc;
#replace_line init.qcom.rc "setprop persist.sys.fp.vendor none" "setprop persist.sys.fp.vendor goodix";
#append_file init.rc "run-parts" init;

# init.tuna.rc
#backup_file init.tuna.rc;
#insert_line init.tuna.rc "nodiratime barrier=0" after "mount_all /fstab.tuna" "\tmount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data remount nosuid nodev noatime nodiratime barrier=0";
#append_file init.tuna.rc "dvbootscript" init.tuna;

# fstab.tuna
#backup_file fstab.tuna;
#patch_fstab fstab.tuna /system ext4 options "noatime,barrier=1" "noatime,nodiratime,barrier=0";
#patch_fstab fstab.tuna /cache ext4 options "barrier=1" "barrier=0,nomblk_io_submit";
#patch_fstab fstab.tuna /data ext4 options "data=ordered" "nomblk_io_submit,data=writeback";
#append_file fstab.tuna "usbdisk" fstab;

# end ramdisk changes

write_boot;

## end install

