#
# Copyright (C) 2013 The Android Open Source Project
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

TARGET_USE_PREBUILT_KERNEL := true

# Inherit common Omni configurations
$(call inherit-product, vendor/omni/config/common.mk)

# Specify phone tech before including full_phone
$(call inherit-product, vendor/omni/config/gsm.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/golden/device.mk)

# Device identifier
PRODUCT_MODEL := GT-I8190
PRODUCT_BRAND := samsung
PRODUCT_NAME := omni_golden
PRODUCT_DEVICE := golden
PRODUCT_MANUFACTURER := Samsung

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=goldenxx \
    TARGET_DEVICE=golden \
    PRIVATE_BUILD_DESC="goldenxx-user 4.1.2 JZO54K I8190XXAMG4 release-keys" \
    BUILD_FINGERPRINT="samsung/goldenxx/golden:4.1.2/JZO54K/I8190XXAMG4:user/release-keys"
