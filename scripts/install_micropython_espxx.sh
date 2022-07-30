# Helper commands to install ESPxx microcontrollers in your computer, via command line.

# Install esptool
pip install esptool

# Define manually the chip name
export ESP_CHIPNAME="ESP8266"
MICROPYTHON_DOWNLOAD_URL=https://micropython.org/resources/firmware/esp8266-512k-20220618-v1.19.1.bin
MICROPYTHON_ROM_PATH=$HOME/Downloads/esp8266-512k-20220618-v1.19.1.bin
export ESP_BAUDRATE=460800

# Set the ports
export ESP_PORT_1=/dev/$(ls /dev | grep usb | grep cu | grep 1)
export ESP_PORT_2=/dev/$(ls /dev | grep usb | grep cu | grep 2)
export ESP_PORT_3=/dev/$(ls /dev | grep usb | grep cu | grep 3)
export ESP_PORT_4=/dev/$(ls /dev | grep usb | grep cu | grep 4)
export ESP_PORT_5=/dev/$(ls /dev | grep usb | grep cu | grep 5)
export ESP_PORT_6=/dev/$(ls /dev | grep usb | grep cu | grep 6)

# Erase the flash memory in the chip
esptool.py \
--port $ESP_PORT \
--chip $ESP_CHIPNAME \
erase_flash

# Download micropython
# https://micropython.org/resources/firmware/esp8266-512k-20220618-v1.19.1.bin

# Download and install
curl $MICROPYTHON_DOWNLOAD_URL \
-o $MICROPYTHON_ROM_PATH &&

esptool.py \
--port $ESP_PORT_1  \
--chip $ESP_CHIPNAME \
--baud $ESP_BAUDRATE write_flash \
--flash_size=detect \
-fm dout 0 \
$MICROPYTHON_ROM_PATH
