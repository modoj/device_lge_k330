#!system/bin/sh

busybox chcon -R u:object_r:keystore_data_file:s0 /data/misc/keystore
