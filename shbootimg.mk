LOCAL_PATH := $(call my-dir)
LZMA_BIN := $(shell which lzma)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

$(recovery_uncompressed_ramdisk): $(MKBOOTFS) \
		$(INSTALLED_BOOTIMAGE_TARGET) \
		$(INTERNAL_RECOVERYIMAGE_FILES) \
		$(recovery_initrc) $(recovery_sepolicy) $(recovery_kernel) \
		$(INSTALLED_2NDBOOTLOADER_TARGET) \
		$(recovery_build_prop) $(recovery_resource_deps) $(recovery_root_deps) \
		$(recovery_fstab) \
		$(RECOVERY_INSTALL_OTA_KEYS)
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib/modules
	cp -f $(TARGET_OUT)/lib/modules/j4fs.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/j4fs.ko
	cp -f $(TARGET_OUT)/lib/modules/param.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/param.ko
	$(call build-recoveryramdisk)
	@echo -e ${PRT_IMG}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_kernel) \
		$(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Compressing recovery ramdisk using LZMA ------"${CL_RST}
	$(hide) rm -f $(OUT)/ramdisk-recovery.cpio.lzma
	$(LZMA_BIN) $(recovery_uncompressed_ramdisk)
	$(hide) cp $(recovery_uncompressed_ramdisk).lzma $(recovery_ramdisk)
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
