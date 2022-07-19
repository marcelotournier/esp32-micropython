# ESP8266 Setup

I am using a macbook pro M2, but I assume the setup will be the same for other computers, by following the tutorial from https://docs.micropython.org/en/latest/esp32/tutorial/intro.html

## 1. Installing dependencies

Installing esptool:
```
pip install esptool
```

### 2. Erasing the factory firmware

To install micropython you must first erase the original factory firmware.

To do it, connect the ESP32 in the USB port, wait for the `PWR` LED to light and run in terminal:
```
esptool.py --port /dev/tty.usbserial-0001 erase_flash
```

In my Mac, the tty port was `/dev/tty.usbserial-0001`. To find the right tty port, you can run `ls /dev | grep usb`

In my case I was getting the error
```
A fatal error occurred: Failed to connect to Espressif device: Wrong boot mode detected (0x13)! The chip needs to be in download mode.
For troubleshooting steps visit: https://docs.espressif.com/projects/esptool/en/latest/troubleshooting.html
```

I followed the guide from https://docs.espressif.com/projects/esptool/en/latest/troubleshooting.html
and in my case I had to put the board in Download mode manually. So I looked at the extra instructions
at https://docs.espressif.com/projects/esptool/en/latest/esp32/advanced-topics/boot-mode-selection.html#manual-bootloader.

In my case I had to keep the `boot` button in the board pressed while I re-ran the `estool.py` command above.

### 3. Downloading micropython firmware

I downloaded the most recent version from [https://micropython.org/download/#esp32](https://micropython.org/download/esp32/)

### 4. Install firmware
Go to where you downloaded the firmware file and run:
```
esptool.py --chip esp32 --port /dev/tty.usbserial-0001 --baud 460800 write_flash -z 0x1000 esp32-20220618-v1.19.1.bin
```
