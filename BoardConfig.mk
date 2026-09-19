#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/dijun
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Inherit from O1_asic-common
include device/xiaomi/O1_asic-common/BoardConfigCommon.mk

# Display
TARGET_SCREEN_DENSITY := 520

# Kernel
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/images/dtbs/
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/images/dtbo.img
PRODUCT_COPY_FILES += \
	$(KERNEL_PATH)/images/kernel:kernel

GKI_VERSION := 6.18.21-android17-5-g1d099fcb35e0-abogki538445360-4k
DLKM_MODULES_PATH := $(KERNEL_PATH)/modules/vendor_dlkm
RAMDISK_MODULES_PATH := $(KERNEL_PATH)/modules/vendor_boot
SYSTEM_DLKM_MODULES_PATH := $(KERNEL_PATH)/modules/system_dlkm/$(GKI_VERSION)
SYSTEM_DLKM_FLATTEN_MODULES_PATH := $(KERNEL_PATH)/modules/system_dlkm/flatten/lib/modules

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(SYSTEM_DLKM_MODULES_PATH)/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/lib/modules/$(GKI_VERSION)/) \
    $(call find-copy-subdir-files,*,$(SYSTEM_DLKM_FLATTEN_MODULES_PATH)/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/flatten/lib/modules/)

BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DLKM_MODULES_PATH)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DLKM_MODULES_PATH)/%,$(shell cat $(DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RAMDISK_MODULES_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

TARGET_ODM_PROP += $(DEVICE_PATH)/configs/properties/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Inherit from the proprietary version
include vendor/xiaomi/dijun/BoardConfigVendor.mk