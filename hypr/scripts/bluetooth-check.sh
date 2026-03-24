#!/bin/bash

# Check if Bluetooth is powered on
BT_POWERED=$(bluetoothctl show | grep "Powered" | cut -d ' ' -f 2)

if [ "$BT_POWERED" != "yes" ]; then
  # If Bluetooth is off, output 'off' with icon
  echo " Off"
  exit 0
fi

# Check if any Bluetooth device is connected
CONNECTED_DEVICES=$(bluetoothctl devices | grep "Device" | cut -d ' ' -f 2)

if [ -n "$CONNECTED_DEVICES" ]; then
  # If Bluetooth device is connected, display device name and battery percentage
  DEVICE_NAME=$(bluetoothctl info $CONNECTED_DEVICES | grep "Name" | cut -d ' ' -f 2-)
  DEVICE_BATTERY=$(bluetoothctl info $CONNECTED_DEVICES | grep "Battery" | cut -d ' ' -f 2)

  if [ -n "$DEVICE_BATTERY" ]; then
    # Display device name and battery percentage
    echo "$DEVICE_NAME $DEVICE_BATTERY% "
  else
    # Display device name without battery info
    echo "$DEVICE_NAME "
  fi
else
  # If no Bluetooth device is connected, output 'Disconnected' with icon
  echo " Disconnected"
fi
