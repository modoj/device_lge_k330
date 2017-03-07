#!/system/bin/sh

chown -h root.system /sys/devices/platform/msm_hsusb/gadget/wakeup
chmod -h 220 /sys/devices/platform/msm_hsusb/gadget/wakeup

echo qti,bam > /sys/class/android_usb/android0/f_rmnet/transports

echo 1  > /sys/class/android_usb/f_mass_storage/lun/nofua

# soc_ids for 8916/8939 differentiation
if [ -f /sys/devices/soc0/soc_id ]; then
    soc_id=`cat /sys/devices/soc0/soc_id`
else
    soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

# enable rps cpus on msm8939/msm8909 target
setprop sys.usb.rps_mask 0
case "$soc_id" in
    "239" | "241" | "263")
        setprop sys.usb.rps_mask 10
    ;;
    "245" | "260" | "261" | "262"
        setprop sys.usb.rps_mask 2
    ;;
esac
