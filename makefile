CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS= -c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
LDFLAGS= -mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=nano.specs -T stm32_ls.ld -Wl,-Map=final.map
LDFLAGS_SH= -mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=rdimon.specs -T stm32_ls.ld -Wl,-Map=final.map
CC_HEX= arm-none-eabi-objcopy
HEX_FLAGS= -O ihex


SRC     := ./
SRCS    := $(wildcard $(SRC)/*.c)
OBJS    := $(patsubst $(SRC)/%.c,$(OBJ)/%.o,$(SRCS))


all:final.elf final.hex

final.elf: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) $< -o $@

final.hex:final.elf
	$(CC_HEX) $(HEX_FLAGS) $^ $@

clean:
	rm -rf *.o *.elf *.map *.hex