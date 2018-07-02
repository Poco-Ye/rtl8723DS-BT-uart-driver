FW_DIR	:= /lib/firmware/rtlbt
FW_NAME := rtl8723d_fw
CF_NAME := rtl8723d_config
all:
	@echo "Copy RTL8723D fw/config to $(FW_DIR)"
	cp -f $(FW_NAME) $(FW_DIR)/$(FW_NAME)
	cp -f $(CF_NAME) $(FW_DIR)/$(CF_NAME)
clean:
