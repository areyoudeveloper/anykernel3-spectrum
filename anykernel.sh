# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.cleanup=1
do.cleanuponabort=0
kernel.string=Welcome to Catalyst kernel X ver 2! 
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=rolex
device.name2=redmi4a
device.name3=
device.name4=
device.name5=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
chmod -R 750 $ramdisk/*;
chmod -R 755 $ramdisk/sbin/*;
chmod +x $ramdisk/sbin/spa
chown -R root:root $ramdisk/*;


ui_print "Catalyst kernel by Anoop";
ui_print "This kernel supports Spectrum performance profiles select one by downloading the app or live with the default.";

## AnyKernel install
dump_boot;

# begin ramdisk changes

#remove old spectrum profile
rm -rf $overlay/init.spectrum.rc

# Spectrum Support
backup_file init.rc;
grep "import /init.spectrum.rc" init.rc >/dev/null || sed -i '1,/.*import.*/s/.*import.*/import \/init.spectrum.rc\n&/' init.rc
insert_line init.rc "init.optimkang.sh" after "import /init.spectrum.rc" "exec u:r:init:s0 -- /init.optimkang.sh";

# end ramdisk changes

write_boot;

## end install

