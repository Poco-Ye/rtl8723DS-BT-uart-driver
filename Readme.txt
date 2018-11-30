In this document, we introduce how to support rtk UART BT driver in Linux system.
Support kernel version 2.6.32~4.8

===========================================================================================================
The default settings of RTK BT chip are H5 protocol, Flow control on, parity even and use internel 32k clock.
The default baund rate is 115200.
To support H5 protocal,you need to install hci_uart driver and rtk_hciattach tool.

1.make sure your hardware setting is correct according to Rtk8723BS support document.

2.Install rtk_hciattach tool and Install uart driver

	Insert BT dongle and Enable Bluetooth as follows:

	1) sudo make install

	2) sudo rtk_hciattach -n -s 115200 ttyUSB0 rtk_h5

tips:ttyUSB0 is serial port name in your system, you should change it according to hardware such as ttyS0.

3. Uninstall
	sudo make uninstall
	unplug RTK bt dongle


===========================================================================================================
if you want to change the parameter such as baud rate and pcm settings, 
you should modify rtlbt_config file which is described in  support document.


===========================================================================================================
 if you want to use h4 protocol, make sure
(1) efuse setting is set to use H4
(2) sudo rtk_hciattach -n -s 115200 ttyUSB0 rtk_h4
===========================================================================================================


运行rtk_hciattach之后运行hciconfig hci0 up和hciconfig hci0 reset。

echo 0 > /sys/class/rfkill/rfkill0/state




echo 0 > /sys/class/rfkill/rfkill0/state

sleep 2

echo 1 > /sys/class/rfkill/rfkill0/state

sleep 2

insmod /usr/lib/modules/hci_uart.ko

rtk_hciattach -n -s 115200 /dev/ttyS0 rtk_h5 &

hciconfig hci0 up

/usr/libexec/bluetooth/bluetoothd --compat -n  &
sleep 1
sdptool add A2SNK
sleep 1
hciconfig hci0 up
sleep 1
hciconfig hci0 piscan
sleep 1
hciconfig hci0 name 'realtek_bt'
sleep 1
hciconfig hci0 down
sleep 1
hciconfig hci0 up
sleep 2
bluealsa --profile=a2dp-sink &
sleep 1
bluealsa-aplay --profile-a2dp 00:00:00:00:00:00 &
sleep 1
hciconfig hci0 class 0x240404


交叉编译：
ARCH := arm
CROSS_COMPILE := arm-linux-gnueabihf-
KSRC := ../../../kernel/

ifeq ($(KERNELRELEASE), )
PWD :=$(shell pwd)
all:
	$(MAKE) CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH) -C $(KSRC) M=$(shell pwd)  modules
clean:
	rm -rf .tmp_versions Module.symvers *.mod.c *.o *.ko .*.cmd Module.markers modules.order
else
	obj-m		:= hci_uart.o
	hci_uart-y	:= hci_ldisc.o hci_h4.o hci_rtk_h5.o rtk_coex.o
endif



export PATH=$PATH:/opt/nationalchip/toolchain-arm_cortex-a7+neon_gcc-5.3.0_glibc-2.22_eabi/bin
export STAGING_DIR=$PWD/../../openwrt/staging_dir
export PATH=$PATH:$STAGING_DIR/toolchain-arm_cortex-a7+neon_gcc-5.3.0_glibc-2.22_eabi/bin

cat /proc/net/rtl8723ds/wlan0/btcoex  cat proc/net/rtl8723ds/ver_info  rtw_version.h
