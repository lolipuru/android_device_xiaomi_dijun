#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import extract_utils.tools
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'vendor/xiaomi/O1_asic-common',
]

blob_fixups: blob_fixups_user_type = {
    (
        'odm/etc/camera/default_snsc_bokeh_motiontuning.xml',
        'odm/etc/camera/default_snsc_enhance_motiontuning.xml',
        'odm/etc/camera/default_snsc_motiontuning.xml',
    ): blob_fixup()
        .regex_replace('xml=version', 'xml version'),
    (
       'vendor/lib64/vendor.xiaomi.hardware.camera.injection-V1-ndk.so',
       'vendor/lib64/vendor.xiaomi.hardware.camera.injection-client.so',
       'vendor/lib64/vendor.xiaomi.hardware.camera.injection-service.so',
    ): blob_fixup()
        .replace_needed(
            'android.hardware.camera.device-V1-ndk.so',
            'android.hardware.camera.device-V2-ndk.so'
        ),
    (
        'vendor/lib64/camera.device-external-impl.so',
    ): blob_fixup()
        .replace_needed('android.hardware.graphics.common-V5-ndk.so', 'android.hardware.graphics.common-V7-ndk.so'),
    (
        'vendor/lib64/com.xiaomi.immunesystem.bigdata2.so',
        'vendor/lib64/libcameraopt.so',
        'vendor/lib64/libcameraopt.so',
        'vendor/lib64/libcom.xiaomi.threadpool.so',
        'vendor/lib64/librcam_cdi.so',
    ): blob_fixup()
        .add_needed('libprocessgroup_shim.so'),
    (
        'odm/lib64/libTrueSight.so',
        'odm/lib64/libAncHumanPreviewBokeh.so',
        'odm/lib64/libwa_widelens_undistort.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('AHardwareBuffer_unlock')
        .clear_symbol_version('AHardwareBuffer_lock'),
}

module = ExtractUtilsModule(
    'dijun',
    'xiaomi',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    check_elf=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'O1_asic-common', module.vendor
    )
    utils.run()