MAKEFILE=Makefile

BUILD_DIR=boot

$(BUILD_DIR)/boot_floppy.bin: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/boot.bin $(BUILD_DIR)/boot_floppy.img
	truncate -s 1440k $(BUILD_DIR)/boot_floppy.img

$(BUILD_DIR)/main.bin:
# in case more steps are needed

clean:
	$(RM) -fr ./boot/boot.bin ./boot/boot_floppy.img