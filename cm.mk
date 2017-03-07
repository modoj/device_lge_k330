# Boot animation
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 854

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

$(call inherit-product, device/lge/ms330/ms330.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ms330
PRODUCT_NAME := cm_ms330
PRODUCT_BRAND := lge
PRODUCT_MODEL := MS330
PRODUCT_MANUFACTURER := LGE
PRODUCT_RELEASE_NAME := LG MS330

PRODUCT_BUILD_PROP_OVERRIDES += \
	PRODUCT_NAME=m1_tmo_us-user \
	BUILD_FINGERPRINT=lge/m1_tmo_us/m1:5.1.1/LMY47V/162041145cedc:user/release-keys \
	PRIVATE_BUILD_DESC="m1_tmo_us-user 5.1.1 LMY47V 162041145cedc release-keys"
