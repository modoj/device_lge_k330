#!/sbin/sh
echo "I:POSTRECOVERYBOOT: Begin."

dmesg > /cache/recovery/kmsg.log
cp /cache/recovery/kmsg.log /sdcard/kmsg.log
cp /cache/recovery/kmsg.log /cache/kmsg.log
cat /proc/last_kmsg > /cache/recovery/lastkmsg.log

echo "I:POSTRECOVERYBOOT: attempting output dump log..."
/system/bin/dumpstate > /cache/recovery/dump.log
cp /cache/recovery/dump.log /data/logger/dump.log
cp /cache/recovery/dump.log /sdcard/dump.log
cp /cache/recovery/dump.log /cache/dump.log

# Wait for system to settle down
#sleep 5

echo "I:POSTRECOVERYBOOT: Logcat attempt!"
/system/bin/logcat -d -v threadtime -b events -b main -b system –b radio > /cache/recovery/cat.log

echo "I:POSTRECOVERYBOOT: dumpling end."
