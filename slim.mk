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

# Inherit GSM telephony parts
$(call inherit-product, vendor/slim/config/gsm.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 800
TARGET_SCREEN_WIDTH := 480

# Inherit common Slim configurations
$(call inherit-product, vendor/slim/config/common_full_phone.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/golden/device.mk)

# Device identifier
PRODUCT_MODEL := GT-I8190
PRODUCT_BRAND := samsung
PRODUCT_NAME := slim_golden
PRODUCT_DEVICE := golden
PRODUCT_MANUFACTURER := Samsung

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=goldenxx \
    TARGET_DEVICE=golden \
    PRIVATE_BUILD_DESC="goldenxx-user 4.1.2 JZO54K I8190XXAMG4 release-keys" \
    BUILD_FINGERPRINT="samsung/goldenxx/golden:4.1.2/JZO54K/I8190XXAMG4:user/release-keys"
