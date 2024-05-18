MAKEFILE=Makefile

export CC=gcc
export LD=ld
export RM=rm
export AR=ar
export AS=nasm

export CFLAGS=-m64 -Wall -O -nostdlib -nostdinc -fno-builtin -fno-pie

#LIB=src/lib
BOOT=src/boot
KERNEL=src/kernel
BIN=bin



all: image

boot:
	$(MAKE) -C $(BOOT)

kernel:
	$(MAKE) -C $(KERNEL)

clean:
	$(MAKE) -C $(BOOT) clean
	$(MAKE) -C $(KERNEL) clean
	$(MAKE) -C $(BIN) clean

image: boot kernel
	echo "HEEEELO"
	mkdir -p $(BIN)/kernel
	mkdir -p $(BIN)/boot 
	$(MAKE) -C $(BIN)
