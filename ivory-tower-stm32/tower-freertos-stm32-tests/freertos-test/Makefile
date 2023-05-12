CC := arm-none-eabi-gcc
CFLAGS := \
  -g3 -Wall -Werror -O2 \
  -std=gnu99 \
  -Wno-parentheses -Wno-unused-variable \
  -mlittle-endian \
  -mthumb -mcpu=cortex-m4 \
  -mfloat-abi=hard -mfpu=fpv4-sp-d16 \
  -DIVORY_TEST

OBJDIR := obj
OBJS := $(addprefix $(OBJDIR)/,freertos_atomic_wrapper.o freertos_semaphore_wrapper.o freertos_mutex_wrapper.o freertos_task_wrapper.o freertos_time_wrapper.o list.o queue.o tasks.o timers.o port.o heap_1.o syscalls.o)

default: $(OBJDIR) $(OBJS)

$(OBJDIR)/%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	-rm -rf obj

veryclean: clean
	-rm *.c *.h
