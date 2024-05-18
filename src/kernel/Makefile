MAKEFILE=Makefile

TARGET_BIN=kernel.bin
TARGET_KERNEL=kernel.o

TARGET_DIR=../../bin/kernel

ASFLAGS=-f bin


all: $(TARGET_BIN) $(TARGET_KERNEL)


$(TARGET_BIN):
	$(AS) *.asm -o $(TARGET_DIR)/$(TARGET_BIN)

$(TARGET_KERNEL):
	$(CC) $(CFLAGS) kernel.c -o kernel.o

clean:
	$(RM) -fr *.o
