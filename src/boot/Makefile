MAKEFILE=Makefile

TARGET_BIN=boot.bin

TARGET_DIR=../../bin/boot

ASFLAGS=-f bin


all: $(TARGET_BIN)
	@mkdir -p $(TARGET_DIR)

$(TARGET_BIN):
	@mkdir -p $(TARGET_DIR)
	$(AS) *.asm -o $(TARGET_DIR)/$(TARGET_BIN)

clean:
#;	$(RM) -fr *.o
