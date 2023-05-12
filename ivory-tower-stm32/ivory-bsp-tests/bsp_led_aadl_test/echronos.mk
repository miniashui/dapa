# This makefile is autogenerated. DO NOT EDIT.

SHELL := /bin/bash

ROOT := $(shell pwd)

SRC := $(ROOT)/.

EXE := image

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
UPLOAD_PORT?=/dev/serial/by-id/usb-3D_Robotics*
endif

ARM_PATH ?= 

AS := $(ARM_PATH)arm-none-eabi-as -mthumb -g3 -mlittle-endian -mcpu=cortex-m4 \
      -mfloat-abi=hard -mfpu=fpv4-sp-d16 -I$(SRC)

CC := $(ARM_PATH)arm-none-eabi-gcc

CFLAGS := -Os -g3 -Wall -Werror              \
          -std=gnu99                         \
          -Wno-parentheses                   \
          -Wno-unused-function               \
          -Wno-unused-variable               \
          -Wno-main                          \
          -mlittle-endian                    \
          -mthumb -mcpu=cortex-m4            \
          -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
          -I$(SRC)                           \
          -I$(SRC)/include \
          -I$(SRC)/gen                       \
          -I$(SRC)/echronos_gen

LDSCRIPT := $(SRC)/echronos_gen/default.ld

LDFLAGS := -Wl,--script=$(LDSCRIPT)           \
           -nodefaultlibs                     \
           -mlittle-endian                    \
           -mthumb -mcpu=cortex-m4            \
           -mfloat-abi=hard -mfpu=fpv4-sp-d16

LDLIBS := -lm -lc -lnosys -lgcc

LD := $(ARM_PATH)arm-none-eabi-gcc

SOURCES_GCC := $(wildcard $(SRC)/*.c)                    \
               $(wildcard $(SRC)/gen/*.c)                \
               $(wildcard $(SRC)/echronos_gen/*.c)

SOURCES_AS := $(wildcard $(SRC)*.s)                     \
              $(wildcard $(SRC)/gen/*.s)                \
              $(wildcard $(SRC)/echronos_gen/*.s)

OBJECTS_GCC := $(SOURCES_GCC:.c=.o)

OBJECTS_AS := $(SOURCES_AS:.s=.o)

VPATH := $(SRC)

OBJCOPY := $(ARM_PATH)arm-none-eabi-objcopy

$(EXE): $(OBJECTS_GCC) $(OBJECTS_AS)
	@echo building executable from assembly files: $(OBJECTS_AS) and .c files: $(OBJECTS_GCC)
	@echo linking executable
	$(LD) $(LDFLAGS) -o $@ $^ $(LDLIBS)


bl_image.bin: $(EXE)
	$(OBJCOPY) -O binary $< $@


image.px4: bl_image.bin
	python px_mkfw.py --prototype=px4fmu-v2.prototype  --image=$< > $@


ifndef UPLOAD_PORT
upload: image.px4
	@echo "*** User expected to set UPLOAD_PORT environment variable, exiting. ***"

else
upload: image.px4
	@echo "*** Uploading ***"
	python px_uploader.py --port=$(UPLOAD_PORT) $<

endif

.PHONY: echronos-clean


echronos-clean: 
	@echo remove all the object files
	rm -f *.o
	@echo remove the executable, if any
	rm -f $(SYS)


