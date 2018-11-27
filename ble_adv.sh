#!/bin/sh
# ref: http://www.theregister.co.uk/Print/2013/11/29/feature_diy_apple_ibeacons/
set -x
export BLUETOOTH_DEVICE=hci0
# initialize device
hciconfig $BLUETOOTH_DEVICE up
# disable advertising 
hciconfig $BLUETOOTH_DEVICE noleadv
# stop the dongle looking for other Bluetooth devices
hciconfig $BLUETOOTH_DEVICE noscan

#sudo hciconfig $BLUETOOTH_DEVICE name "i5-3210M "$BLUETOOTH_DEVICE
#hciconfig $BLUETOOTH_DEVICE leadv

# set advertise data
hcitool -i $BLUETOOTH_DEVICE cmd 0x08 0x0008 16 02 01 05 03 03 12 18 03 19 C1 03 04 09 52 43 55 05 FF 5D 00 04 00
# set scan response data
hcitool -i $BLUETOOTH_DEVICE cmd 0x08 0x0009 04 03 19 C1 03
# set random address (resolvable private address)
hcitool -i $BLUETOOTH_DEVICE cmd 0x08 0x0005 11 02 03 44 55 7F
# set adv parameters
hcitool -i $BLUETOOTH_DEVICE cmd 0x08 0x0006 A0 00 A0 00 00 01 00 00 00 00 00 00 00 07 00
# le enable adv
hcitool -i $BLUETOOTH_DEVICE cmd 0x08 0x000a 01

echo "complete"
