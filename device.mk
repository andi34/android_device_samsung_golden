#
# Copyright (C) 2013 The Android Open Source Project
# Copyright (C) 2013 Óliver García Albertos (oliverarafo@gmail.com)
# Copyright (C) 2014 SlimRoms Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifeq ($(TARGET_USE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := device/samsung/golden/prebuilt/zImage

PRODUCT_COPY_FILES := \
	$(TARGET_PREBUILT_KERNEL):kernel

ifndef BOARD_CUSTOM_BOOTIMG_MK
PRODUCT_PACKAGES += \
    bthid.ko \
    dhd.ko \
    exfat_core.ko \
    exfat_fs.ko \
    hwreg.ko \
    j4fs.ko \
    joydev.ko \
    param.ko \
    rng-core.ko \
    scsi_wait_scan.ko \
    vpnclient.ko \
    xpad.ko
endif
endif

# Define kind of DPI
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.samsunggolden \
    init.samsunggolden.rc \
    init.samsunggolden.usb.rc \
    lpm.rc \
    ueventd.samsunggolden.rc

# Recovery ramdisk
PRODUCT_PACKAGES += \
    init.recovery.samsunggolden.rc \
    twrp.fstab
	
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.use_dithering=2 \
    persist.sys.strictmode.disable=1

# USB
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb \
    persist.service.adb.enable=1 \
    ste.special_fast_dormancy=false

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# F2FS filesystem
PRODUCT_PACKAGES += \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    f2fstat

# Use the Dalvik VM specific for devices with 1024 MB of RAM
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
