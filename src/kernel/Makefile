MAKEFILE=Makefile

TARGET_BIN=kernel.bin

TARGET_DIR=../../bin/kernel

ASFLAGS=-f bin


all: $(TARGET_BIN)


$(TARGET_BIN):
	$(AS) *.asm -o $(TARGET_DIR)/$(TARGET_BIN)

clean:
#;	$(RM) -fr *.o