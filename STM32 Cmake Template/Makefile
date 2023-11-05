# Jacob Chisholm
# Makefile for compiling and uploading bare metal code
# to STMF446 with BlackMagic Probe + GDB
CFLAGS  ?=  -W -Wall -Wextra -Werror -Wundef -Wshadow -Wdouble-promotion \
            -Wformat-truncation -fno-common -Wconversion \
            -g3 -Os -ffunction-sections -fdata-sections \
            -I. -Iinclude -Icmsis_core/CMSIS/Core/Include -Icmsis_f4/Include \
            -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 $(EXTRA_CFLAGS)
LDFLAGS ?= -Tcore/STM32F446RETX_FLASH.ld -nostartfiles -nostdlib --specs nano.specs -lc -lgcc -Wl,--gc-sections -Wl,-Map=$@.map
SOURCES = src/*
SOURCES += core/startup_stm32f446retx.s # ST startup file. Compiler-dependent!

COMPORT = COM3

#build: firmware.elf

# firmware.elf: cmsis_core cmsis_f4 core Makefile $(SOURCES)
# 	arm-none-eabi-gcc $(SOURCES) $(CFLAGS) $(CFLAGS_EXTRA) $(LDFLAGS) -o $@

# firmware.bin: firmware.elf
# 	arm-none-eabi-objcopy -O binary $< $@

cmake:
	mkdir build
	cd build
	cmake ..

# must run "run" command or restart target to start program
flash:
	gdb -ex 'target extended-remote $(COMPORT)' \
	-ex 'set mem inaccessible-by-default off' \
	-ex 'monitor swdp' \
	-ex 'attach 1' \
	-ex 'load firmware.elf' \
	-q

clean:
	rm firmware.*

cmsis_core:
	cd core
	git clone --depth 1 -b 5.9.0 https://github.com/ARM-software/CMSIS_5 $@
	cd ../
  
cmsis_f4: 
	cd core
	git clone --depth 1 -b v2.6.8 https://github.com/STMicroelectronics/cmsis_device_f4 $@
	cd ../