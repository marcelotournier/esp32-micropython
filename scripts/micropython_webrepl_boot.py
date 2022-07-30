"""
This file is executed on every boot
(including wake-boot from deepsleep)
RENAME THIS TO boot.py BEFORE LOADING IT IN
THE MICRO CONTROLLER!

Get the webrepl in:
https://github.com/micropython/webrepl
"""
import esp
import webrepl
import network


# Deactivating debug mode
esp.osdebug(None)

# Starting webREPL
webrepl.start()

# Create AP during boot:
SSID = "Micropython-ESP32"
PASS = "123123"
ap = network.WLAN(network.AP_IF)
ap.active(True)
ap.config(essid=SSID, password=PASS)
