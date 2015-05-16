LOCAL_PATH := $(call my-dir)
LZMA_BIN := $(shell which lzma)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
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
		$(recovery_ramdisk)
	@echo ----- Compressing recovery ramdisk using LZMA ------
	$(hide) rm -f $(OUT)/ramdisk-recovery.cpio.lzma
	$(LZMA_BIN) $(recovery_uncompressed_ramdisk)
	$(hide) cp $(recovery_uncompressed_ramdisk).lzma $(recovery_ramdisk)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
