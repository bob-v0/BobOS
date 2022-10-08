MAKEFILE=Makefile

BUILD_DIR=boot
KERNEL_DIR=kernel


$(BUILD_DIR)/boot_floppy.bin:
	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=512 count=2880
	mkfs.fat -F 12 -n "BOBOS" $(BUILD_DIR)/main_floppy.img
	dd if=$(BUILD_DIR)/boot.bin of=$(BUILD_DIR)/main_floppy.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main_floppy.img $(KERNEL_DIR)/kernel.bin "::kernel.bin"
#	cp $(BUILD_DIR)/boot.bin $(BUILD_DIR)/boot_floppy.img
#	truncate -s 1440k $(BUILD_DIR)/boot_floppy.img


clean:
	$(RM) -fr ./boot/boot.bin ./boot/boot_floppy.img
	$(RM) -fr ./kernel/kernel.bin
