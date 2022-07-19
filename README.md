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

### 5. Accessing the Micropython REPL
You must get it through the usb port using `picocom`. This command should exist in linux (based on what the docs said). For mac, install it
with homebrew (https://brew.sh/)
```
brew install picocom
```

and then run in your port:
```
picocom /dev/tty.usbserial-0001 -b115200
```

Then... Bingo! You just hacked your first ESP32! :)
```
$ picocom /dev/tty.usbserial-0001 -b115200
picocom v3.1

port is        : /dev/tty.usbserial-0001
flowcontrol    : none
baudrate is    : 115200
parity is      : none
databits are   : 8
stopbits are   : 1
escape is      : C-a
local echo is  : no
noinit is      : no
noreset is     : no
hangup is      : no
nolock is      : no
send_cmd is    : sz -vv
receive_cmd is : rz -vv -E
imap is        : 
omap is        : 
emap is        : crcrlf,delbs,
logfile is     : none
initstring     : none
exit_after is  : not set
exit is        : no

Type [C-a] [C-h] to see available commands
Terminal ready
EK:?MicroPython v1.19.1 on 2022-06-18; ESP32 module with ESP32
Type "help()" for more information.
>>>
```

To exit the picocom connection to the REPL do `Ctrl-a` then `Ctrl-x`

### 6. Copying files to ESP32:

I am using ampy, from adafruit (https://github.com/scientifichackers/ampy):
```
# ref: https://boneskull.com/micropython-on-esp32-part-1/
pip install adafruit-ampy
```

To list files:
```
ampy -p /dev/tty.usbserial-0001 ls
```

To get file contents:
```

```

To put a file in ESP32 (DANGER - it overwrites):
```

```

### 7. Configuring network:
```
import network

# Checking which mode it is - access point or client mode:
sta_if = network.WLAN(network.STA_IF)
ap_if = network.WLAN(network.AP_IF)

# station interface?
sta_if.active()
# False

# access point interface?
ap_if.active()
# True
```

Connecting as AP interface:
```
SSID = "Micropython-ESP32"
PASS = "123123"
ap = network.WLAN(network.AP_IF)
ap.active(True)
ap.config(essid=SSID, password=PASS)
```

WebREPL

This is a nice way to interact with the ESP32. To setup, run in the micropython shell:
```
import webrepl_setup
```
and follow the instructions. The first option should be `E` to enable it. Set the password and then accept rebooting.



