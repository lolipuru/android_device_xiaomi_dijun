#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from dijun device.
$(call inherit-product, device/xiaomi/dijun/device.mk)

## Device identifier
PRODUCT_DEVICE := dijun
PRODUCT_NAME := lineage_dijun
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := 25042PN24C
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc=$(call normalize-path-list, "dijun dijun 15 AP3A.240905.015.A2 OS2.0.121.0.VODCNXM:user release-keys")

BUILD_FINGERPRINT := Xiaomi/dijun/dijun:15/AP3A.240905.015.A2/OS2.0.121.0.VODCNXM:user/release-keys

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi