LOCAL_PATH := $(call my-dir)
LZMA_BIN := $(shell which lzma)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
ifeq ($(TARGET_USE_PREBUILT_KERNEL),true)
	mkdir -p $(TARGET_OUT)/lib/modules
	cp -f device/samsung/golden/prebuilt/system/lib/modules/* $(TARGET_OUT)/lib/modules
	@echo -e ${CL_CYN}"----- prebuilt kernel modules ------"${CL_RST}$@
endif
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

$(recovery_uncompressed_ramdisk): $(MINIGZIP) \
		$(TARGET_RECOVERY_ROOT_TIMESTAMP)
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib/modules
	cp -f $(TARGET_OUT)/lib/modules/j4fs.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/j4fs.ko
	cp -f $(TARGET_OUT)/lib/modules/param.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/param.ko
	@echo -e ${CL_CYN}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_kernel) \
		$(recovery_uncompressed_ramdisk) \
		$(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Compressing recovery ramdisk using LZMA ------"${CL_RST}
	$(hide) rm -f $(OUT)/ramdisk-recovery.cpio.lzma
	$(LZMA_BIN) $(recovery_uncompressed_ramdisk)
	$(hide) cp $(recovery_uncompressed_ramdisk).lzma $(recovery_ramdisk)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
