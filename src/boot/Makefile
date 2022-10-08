MAKEFILE=Makefile

TARGET_BIN=boot.bin

TARGET_DIR=../../bin/boot

ASFLAGS=-f bin


all: $(TARGET_BIN)


$(TARGET_BIN):
	$(AS) *.asm -o $(TARGET_DIR)/$(TARGET_BIN)

clean:
#;	$(RM) -fr *.o