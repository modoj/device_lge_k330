# PRIMA symlinks
$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/wlan/prima)
$(shell ln -sf /persist/WCNSS_wlan_dictionary.dat $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_wlan_dictionary.dat)
$(shell ln -sf /persist/WCNSS_qcom_wlan_nv.bin $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin)
$(shell ln -sf /persist/WCNSS_qcom_wlan_nv.bin $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_wlan_nv_boot.bin)
$(shell ln -sf /data/misc/wifi/WCNSS_qcom_cfg.ini $(TARGET_OUT_ETC)/firmware/wlan/prima/WCNSS_qcom_cfg.ini)
