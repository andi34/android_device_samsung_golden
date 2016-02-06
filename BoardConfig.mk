#
# Copyright (C) 2013 The Android Open Source Project
# Copyright (C) 2013 Óliver García Albertos (oliverarafo@gmail.com)
# Copyright (C) 2014 Stefan Berger (s.berger81@gmail.com)
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

TARGET_OTA_ASSERT_DEVICE := golden,i8190,GT-I8190,goldenxx

# Board
TARGET_BOOTLOADER_BOARD_NAME := DB8520H
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform 
TARGET_BOARD_PLATFORM := montblanc
TARGET_SOC := u8500

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_SMP := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
ARCH_ARM_HAVE_NEON := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp

# Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1258291200
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5064622080
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Kernel
TARGET_KERNEL_CONFIG := slim_golden_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/golden
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/golden/shbootimg.mk
BOARD_KERNEL_CMDLINE := "androidboot.selinux=permissive"
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000
TARGET_NOT_USE_GZIP_RECOVERY_RAMDISK := true

# Vold
BOARD_VOLD_MAX_PARTITIONS := 25
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true

# Charging mode
BOARD_LPM_BOOT_ARGUMENT_NAME := lpm_boot
BOARD_LPM_BOOT_ARGUMENT_VALUE := 1

# SELinux
HAVE_SELINUX := true
BOARD_SEPOLICY_DIRS += device/samsung/golden/sepolicy
BOARD_SEPOLICY_UNION += \
    admsrv.te \
    atd.te \
    copsd.te \
    device.te \
    drmserver.te \
    execmem.te \
    file.te \
    file_contexts \
    geomagneticd.te \
    healthd.te \
    init.te \
    keystore.te \
    mediaserver.te \
    orientationd.te \
    rild.te \
    surfaceflinger.te \
    sysinit.te \
    system.te \
    vold.te \
    wpa_supplicant.te \
    zygote.te

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/golden/rootdir/etc/fstab.samsunggolden
RECOVERY_FSTAB_VERSION := 2
BOARD_SUPPRESS_EMMC_WIPE := true
BOARD_UMS_LUNFILE := "/sys/devices/platform/musb-ux500.0/musb-hdrc/gadget/lun0/file"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/musb-ux500.0/musb-hdrc/gadget/lun%d/file"

# TWRP Recovery defines
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_THEME := portrait_mdpi
RECOVERY_SDCARD_ON_DATA := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
BOARD_HAS_NO_REAL_SDCARD := true
TW_NO_USB_STORAGE := true
TW_BRIGHTNESS_PATH := "/sys/devices/mcde_disp_s6e63m0_dsi.0/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 255
TW_INCLUDE_CRYPTO := true
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_NO_CPU_TEMP := true
