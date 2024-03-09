CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS= -c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
LDFLAGS= -mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=nano.specs -T stm32_ls.ld -Wl,-Map=final.map
LDFLAGS_SH= -mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=rdimon.specs -T stm32_ls.ld -Wl,-Map=final.map
CC_HEX= arm-none-eabi-objcopy
HEX_FLAGS= -O ihex


HAL_SRC     	:= ../../HAL_Drivers
HAL_SRCS    	:= $(wildcard $(HAL_SRC)/*.c)
HAL_OBJS    	:= $(patsubst $(HAL_SRC)/%.c,$(HAL_OBJ)/%.o,$(HAL_SRCS))

APP_SRC     	:= ./
APP_SRCS    	:= $(wildcard $(APP_SRC)/*.c)
APP_OBJS    	:= $(patsubst $(APP_SRC)/%.c,$(APP_OBJ)/%.o,$(APP_SRCS))

all: $(BUILD_DIR) final.elf final.hex


final.elf: $(HAL_OBJS) $(APP_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

$(HAL_OBJ)/%.o: $(HAL_SRC)/%.c
	$(CC) $(CFLAGS) $< -o $@

$(APP_OBJ)/%.o: $(APP_SRC)/%.c
	$(CC) $(CFLAGS) $< -o $@

final.hex:final.elf
	$(CC_HEX) $(HEX_FLAGS) $^ $@

clean:
	rm -rf *.o *.elf *.map *.hex
