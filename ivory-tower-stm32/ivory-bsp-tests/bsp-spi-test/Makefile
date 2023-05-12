UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
UPLOAD_PORT?=/dev/serial/by-id/usb-3D_Robotics*
endif
CC := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy
CFLAGS := -Os
TOWER_STM32_CFLAGS := \
  -g3 -Wall -Werror \
  -std=gnu99 \
  -Wno-parentheses \
  -Wno-unused-function \
  -Wno-unused-variable \
  -mlittle-endian \
  -mthumb -mcpu=cortex-m4 \
  -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
  -DIVORY_TEST \
  -DIVORY_USER_ASSERT_HOOK \
  -I.

LDFLAGS := \
  -mlittle-endian \
  -mthumb -mcpu=cortex-m4 \
  -mfloat-abi=hard -mfpu=fpv4-sp-d16
LDLIBS := -lm

OBJDIR := obj
OBJS := $(addprefix $(OBJDIR)/,freertos_atomic_wrapper.o freertos_semaphore_wrapper.o freertos_mutex_wrapper.o freertos_task_wrapper.o freertos_time_wrapper.o list.o queue.o tasks.o timers.o port.o heap_1.o syscalls.o spiDriverTypes.o tower_user_thread_signal_SPI4_IRQHandler.o tower_gen_thread_signal_SPI4_IRQHandler.o tower_user_thread_period_1ms.o tower_gen_thread_period_1ms.o tower_user_thread_period_250ms.o tower_gen_thread_period_250ms.o tower_user_thread_init.o tower_gen_thread_init.o tower_state_monitor_simplecontroller.o tower_gen_monitor_simplecontroller.o tower_state_monitor_spi4PeripheralDriver.o tower_gen_monitor_spi4PeripheralDriver.o tower_init.o stm32_main.o tower_time.o stm32_freertos_init.o vector_table.o stm32_freertos_user_assert.o)

default: $(OBJDIR) $(OBJS) image image.px4

image.px4: bl_image.bin
	python px_mkfw.py --prototype=px4fmu-v2.prototype  --image=$< > $@

bl_image.bin: bl_image
	$(OBJCOPY) -O binary $< $@

bl_image: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) -Wl,--script=bl_linker_script.lds -Wl,-Map=$@.map $(OBJS) $(LDLIBS)

upload: image.px4
ifndef UPLOAD_PORT
	@echo "*** User expected to set UPLOAD_PORT environment variable, exiting. ***"
else
	@echo "*** Uploading ***"
	python px_uploader.py --port=$(UPLOAD_PORT) $<
endif



image: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) -Wl,--script=linker_script.lds -Wl,-Map=$@.map $(OBJS) $(LDLIBS)

$(OBJDIR)/%.o : %.c
	$(CC) $(TOWER_STM32_CFLAGS) $(CFLAGS) -c -o $@ $<

$(OBJDIR)/%.o : %.s
	$(CC) $(TOWER_STM32_CFLAGS) $(CFLAGS) -c -o $@ $<

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	-rm -rf obj
	-rm image
	-rm image.map

