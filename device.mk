#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from o1_asic-common
$(call inherit-product, device/xiaomi/o1_asic-common/common.mk)

# Get non-open-source specific aspects
$(call inherit-product, vendor/xiaomi/dijun/dijun-vendor.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)