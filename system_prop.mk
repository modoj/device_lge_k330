### Audio ###

### Dalvik ###
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=true \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapmaxfree=16m \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.stack-trace-file=/data/anr/traces.txt \
    ro.config.max_starting_bg=32 \
	ro.sys.fw.bg_apps_limit=21 \
	ro.sys.fw.bg_cached_ratio=0.33 \
	persist.thread.lge.count=5 \
	drm.service.enabled=true \
	ro.boot.svelte=1 \
	ro.sf.lcd_density=240

# LOGGER_*.sh
PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.crash.enable=0 \
    persist.service.events.enable=6 \
    persist.service.kernel.enable=6 \
    persist.service.main.enable=6 \
    persist.service.radio.enable=6 \
    persist.service.system.enable=6 \
    persist.sys.ssr.restart_level=3

# Time Daemon
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# system props for the data modules
PRODUCT_PROPERTY_OVERRIDES += \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.data.mode=concurrent \
    DEVICE_PROVISIONED=1

### Telephony ##########################################
#   telephony.lteOnCdmaDevice=1
#   persist.radio.add_power_save=1
#   persist.radio.adb_log_on=1
#   ro.cdma.subscribe_on_ruim_ready=true
# persist.radio.snapshot_enabled=1 \
# persist.radio.snapshot_timer=22 \
# persist.data.sbp.update=0 \
# persist.radio.rat_on=legacy
#    ro.telephony.default_cdma_sub=0 \
#   ro.telephony.get_imsi_from_sim=true \
#   persist.data.sbp.update=0 \
#   persist.radio.no_wait_for_card=1
#     ro.telephony.ril_class=LgeLteRIL
# persist.env.fastdorm.enabled=false \
# persist.radio.msgtunnel.start=false \
# persist.radio.atfwd.start=false
#    ril.subscription.types=NV,RUIM

PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.qcril.disable_retry=true \
    ro.telephony.call_ring.delay=0 \
    ro.telephony.call_ring.multiple=false \
    keyguard.no_require_sim=true

#  0     WCDMA preferred
#  1     GSM only
#  2     WCDMA only
#  3     GSM auto (PRL)
#  4     CDMA auto (PRL)
#  5     CDMA only
#  6     EvDo only
#  7     GSM/CDMA (PRL)
#  8     LTE/CDMA auto (PRL)
#  9     LTE/GSM auto (PRL)
# 10     LTE/GSM/CDMA auto (PRL)
# 11     LTE only
# 12     Unknown
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=10

### ADB
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    persist.sys.root_access=1 \
    ro.debuggable=1

# GPS
# ro.qc.sdk.izat.premium_enabled=0 \
# ro.qc.sdk.izat.service_mask=0x8 \
# persist.gps.qc_nlp_in_use=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.gps.agps_provider=1

### SENSORS ###
# Sensor debugging
# Valid settings (and presumably what they mean):
#   0      - off
#   1      - all the things
#   V or v - verbose
#   D or d - debug
#   E or e - errors
#   W or w - warnings
#   I or i - info
#

# PRODUCT_PROPERTY_OVERRIDES += \
#     debug.qualcomm.sns.daemon=e \
#     debug.qualcomm.sns.hal=w \
#     debug.qualcomm.sns.libsensor1=e

### WIFI ###
#     wifi.interface=wlan0 \
#     wifi.supplicant_scan_interval=15 \

PRODUCT_PROPERTY_OVERRIDES += \
	net.tethering.noprovisioning=true

# QCNE (Qualcomm ConNectivity Engine)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.cne.feature=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.core_ctl_present=1 \
	ro.core_ctl_min_cpu=2 \
	ro.core_ctl_max_cpu=4

# system props for widevine
# PRODUCT_PROPERTY_OVERRIDES += \
# 	persist.gralloc.cp.level3=1

# System property for cabl
PRODUCT_PROPERTY_OVERRIDES += \
	ro.qualcomm.cabl=0

# System property for QDCM
PRODUCT_PROPERTY_OVERRIDES += \
	persist.tuning.qdcm=1 \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.debuggable=1 \
	persist.sys.root_access=1 \
	security.perf_harden=0 \
	ro.allow.mock.location=0 \
	persist.sys.usb.config=mtp,acm,diag,adb \
    persist.sys.strictmode.disable=true
