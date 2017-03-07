#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

ifneq ($(QCPATH),)
$(call inherit-product-if-exists, vendor/qcom/proprietary/common/config/device-vendor.mk)
$(call inherit-product-if-exists, vendor/qcom/proprietary/prebuilt_HY11/target/product/msm8909/prebuilt.mk)
# $(call inherit-product-if-exists, vendor/qcom/proprietary/qrdplus/Extension/products.mk)
endif

# $(call inherit-product-if-exists, vendor/google/products/gms.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Boot animation
TARGET_SCREEN_HEIGHT := 854
TARGET_SCREEN_WIDTH := 480

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.m1 \
    init.m1.rc \
    init.m1.sh \
	init.m1.bt.sh \
    init.m1.sensors.rc \
    init.m1.sensors.sh \
    init.m1.usb.rc \
    ueventd.m1.rc

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/init.m1.crash.sh:root/init.m1.crash.sh \
	$(LOCAL_PATH)/rootdir/init.m1.post-boot.sh:root/init.m1.post-boot.sh \
	$(LOCAL_PATH)/rootdir/init.m1.power.rc:root/init.m1.power.rc \
	$(LOCAL_PATH)/rootdir/init.m1.usb.sh:root/init.m1.usb.sh \
	$(LOCAL_PATH)/rootdir/init.lge.rc:root/init.lge.rc \
	$(LOCAL_PATH)/rootdir/init.lge.log.rc:root/init.lge.log.rc \
	$(LOCAL_PATH)/rootdir/init.lge.zram.sh:root/init.lge.zram.sh \
	$(LOCAL_PATH)/rootdir/init.m1_chcon_keystore.sh:root/init.m1_chcon_keystore.sh

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.m1.rc \
    init.recovery.m1_chcon_keystore.sh \
	librecovery_updater_cm

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/etc/twrp.fstab:recovery/root/etc/twrp.fstab \
	$(LOCAL_PATH)/rootdir/init.recovery.m1_chcon_keystore.sh:recovery/root/init.recovery.m1_chcon_keystore.sh \
	bionic/libc/zoneinfo/tzdata:recovery/root/system/usr/share/zoneinfo/tzdata

PRODUCT_PACKAGES += \
    nano \
    curl \
    libcurl \
    libgpg-error \
    libinit_m1 \
    libglgps-compat

# ETC
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/etc/ramoops_backup.sh:system/etc/ramoops_backup.sh \
	$(LOCAL_PATH)/rootdir/etc/rssi.xml:system/etc/rssi.xml \
    $(LOCAL_PATH)/rootdir/etc/thermal-engine-8909.conf:system/etc/thermal-engine-8909.conf \
    $(LOCAL_PATH)/rootdir/etc/thermal-engine-default.conf:system/etc/thermal-engine-default.conf \
	$(LOCAL_PATH)/rootdir/etc/cne/andsfCne.xml:system/etc/cne/andsfCne.xml \
	$(LOCAL_PATH)/rootdir/etc/cne/SwimConfig.xml:system/etc/cne/SwimConfig.xml \
	$(LOCAL_PATH)/rootdir/etc/data/dsi_config.xml:system/etc/data/dsi_config.xml \
	$(LOCAL_PATH)/rootdir/etc/data/netmgr_config.xml:system/etc/data/netmgr_config.xml \
	$(LOCAL_PATH)/rootdir/etc/data/qmi_config.xml:system/etc/data/qmi_config.xml \
	$(LOCAL_PATH)/rootdir/etc/dpm/dpm.conf:system/etc/dpm/dpm.conf \
	$(LOCAL_PATH)/rootdir/etc/dpm/nsrm/NsrmConfiguration.xml:system/etc/dpm/nsrm/NsrmConfiguration.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/dpmapi.xml:system/etc/permissions/dpmapi.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/qcrilhook.xml:system/etc/permissions/qcrilhook.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/qcnvitems.xml:system/etc/permissions/qcnvitems.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/cneapiclient.xml:system/etc/permissions/cneapiclient.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/com.qcom.bluetooth.xml:system/etc/permissions/com.qcom.bluetooth.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/com.quicinc.cne.xml:system/etc/permissions/com.quicinc.cne.xml \
    $(LOCAL_PATH)/rootdir/etc/permissions/qti_permissions.xml:system/etc/permissions/qti_permissions.xml

# Permissions
PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio \
    antradio_app

# Audio
PRODUCT_PACKAGES += \
	audiod \
    audio.a2dp.default \
    audio.primary.msm8909 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libwebrtc_audio_preprocessing \
    tinycap \
    tinymix \
    tinyplay \
    tinypcminfo

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    $(LOCAL_PATH)/rootdir/etc/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/rootdir/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/rootdir/etc/mixer_paths.xml:system/etc/mixer_paths.xml

# Sensors
# PRODUCT_COPY_FILES += \
#     $(LOCAL_PATH)/rootdir/etc/sensors/hals.conf:system/etc/sensors/hals.conf

# Browser
PRODUCT_PACKAGES += \
    Gello

# Camera
PRODUCT_PACKAGES += \
    camera.msm8909 \
    mm-qcamera-app \
    libmm-qcamera \
	libshim_camera \
    Snap

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# CNE
PRODUCT_PACKAGES += \
    libcnefeatureconfig

# Compatibility
PRODUCT_PACKAGES += \
    libboringssl-compat \
    libril_shim \
    libstlport \
    libssl \
    libcrypto

# Doze
# PRODUCT_PACKAGES += \
#     DozeService

# Doze mode
# PRODUCT_PACKAGES += \
#     LGDoze

# Ebtables
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    libebtc

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	e2fsck_static \
    make_ext4fs \
	resize2fs_static \
    setup_fs \
    setup_fs_static \
    tune2fs_static

# # FM radio
# PRODUCT_PACKAGES += \
# 	qcom.fmradio \
# 	libqcomfm_jni \
# 	FM2 \
# 	FMRecord \
# 	FMRadio \
# 	libfmjni

# Graphics
PRODUCT_PACKAGES += \
    copybit.msm8909 \
    hwcomposer.msm8909 \
    gralloc.msm8909 \
    memtrack.msm8909 \
    libgenlock \
    liboverlay

# GPS
PRODUCT_PACKAGES += \
    gps.msm8909

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/cacert_location.pem:system/etc/cacert_location.pem \
    $(LOCAL_PATH)/rootdir/etc/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/rootdir/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/rootdir/etc/gnss-conf.xml:system/etc/gnss-conf.xml \
    $(LOCAL_PATH)/rootdir/etc/izat.conf:system/etc/izat.conf \
	$(LOCAL_PATH)/rootdir/etc/lowi.conf:system/etc/lowi.conf \
    $(LOCAL_PATH)/rootdir/etc/quipc.conf:system/etc/quipc.conf \
    $(LOCAL_PATH)/rootdir/etc/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/rootdir/etc/xtwifi.conf:system/etc/xtwifi.conf \
    $(LOCAL_PATH)/rootdir/etc/xtra_root_cert.pem:system/etc/xtra_root_cert.pem

# Keylayouts and Keychars
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    $(LOCAL_PATH)/rootdir/usr/keylayout/Generic.kl:system/usr/keylayout/Generic.kl \
    $(LOCAL_PATH)/rootdir/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/rootdir/usr/keylayout/m1-keypad.kl:system/usr/keylayout/m1-keypad.kl \
    $(LOCAL_PATH)/rootdir/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    $(LOCAL_PATH)/rootdir/usr/keychars/m1-keypad.kcm:system/usr/keychars/m1-keypad.kcm \
    $(LOCAL_PATH)/rootdir/usr/keychars/Generic.kcm:system/usr/keychars/Generic.kcm \
    $(LOCAL_PATH)/rootdir/usr/keychars/qwerty.kcm:system/usr/keychars/qwerty.kcm \
    $(LOCAL_PATH)/rootdir/usr/keychars/qwerty2.kcm:system/usr/keychars/qwerty2.kcm \
    $(LOCAL_PATH)/rootdir/usr/keychars/Virtual.kcm:system/usr/keychars/Virtual.kcm

# Input device config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/usr/idc/lge_touch.idc:system/usr/idc/lge_touch.idc \
    $(LOCAL_PATH)/rootdir/usr/idc/pp2106-keypad.idc:system/usr/idc/pp2106-keypad.idc \
    $(LOCAL_PATH)/rootdir/usr/idc/qwerty.idc:system/usr/idc/qwerty.idc \
    $(LOCAL_PATH)/rootdir/usr/idc/qwerty2.idc:system/usr/idc/qwerty2.idc

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/sec_config:system/etc/sec_config

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8909 \
    keymaster_test

# Lights
PRODUCT_PACKAGES += \
    lights.msm8909

# Media config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/rootdir/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/rootdir/etc/media_profiles.xml:system/etc/media_profiles.xml

# Misc
PRODUCT_PACKAGES += \
    libtinyxml \
    libxml2

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdashplayer \
    libdivxdrmdecrypt \
	libextmedia_jni \
	libmm-omxcore \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxSwVencHevc \
    libOmxSwVencMpeg4 \
    libOmxVdec \
    libOmxVenc \
    libOmxVidcCommon \
    libstagefright_soft_flacdec \
    libstagefright_soft_h264dec \
    libstagefright_soft_h264enc \
    libstagefrighthw \
    qcmediaplayer

#ifneq ($(QCPATH),)
PRODUCT_PACKAGES += \
    libOmxVdecHevc
#endif

PRODUCT_BOOT_JARS += \
    qcmediaplayer

# Power HAL
PRODUCT_PACKAGES += \
    power.msm8909

# RIL
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    librmnetctl \
    libxml2 \
    com.android.future.usb.accessory

# Wifi firmware
PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    libwcnss_qmi \
    wcnss_service \
	librmnetctl

# WiFi config
PRODUCT_COPY_FILES += \
    kernel/lge/m1/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/lge/m1/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/rootdir/etc/wifi/FTM_PowerTable.XML:system/etc/wifi/FTM_PowerTable.XML \
    $(LOCAL_PATH)/rootdir/etc/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin \
    $(LOCAL_PATH)/rootdir/etc/wifi/WCNSS_wlan_dictionary.dat:system/etc/wifi/WCNSS_wlan_dictionary.dat

# WPA Supplicant
PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    dhcpcd.conf \
    libwpa_client \
    wpa_supplicant

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/wifi/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny

# Nano & Terminfo
PRODUCT_PACKAGES += \
    ansi \
    dumb \
    linux \
    nano \
    pcansi \
    screen \
    unknown \
    vt100 \
    vt102 \
    vt200 \
    vt220 \
    xterm \
    xterm-color \
    xterm-xfree86

# Bash
PRODUCT_PACKAGES += \
    bash \
    bash.bin \
    bashrc \
    inputrc

# LG SDEncryption
PRODUCT_PACKAGES += \
	dumpsexp \
	hmac256 \
	ecryptfs_manager \
	ecryptfs_wrap_passphrase \
	ecryptfs_unwrap_passphrase \
	ecryptfs_insert_wrapped_passphrase_into_keyring \
	ecryptfs_rewrap_passphrase \
	ecryptfs_add_passphrase \
	ecryptfs-stat \
	gcryptrnd \
	getrandom \
	keyctl \
	mkerrcodes \
	mount.ecryptfs \
	libecryptfs \
	libecryptfs_key_mod_passphrase \
	libgcrypt \
	libgpg-error \
	libkeyutils \
	libtimescale_filter \
	request-key

# LG other
PRODUCT_PACKAGES += \
	freeblk

# Qcom other
PRODUCT_PACKAGES += \
	tcmiface

PRODUCT_PACKAGES += \
	libhealthd.m1 \
	libbt-vendor \
	libnetfilter_conntrack \
	libnfnetlink \
	libwifi-hal-qcom

$(call inherit-product, vendor/lge/m1/m1-vendor.mk)

# System property declarations (used for entries with a space or that are empty)
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop
# System property overrides
include $(LOCAL_PATH)/system_prop.mk
