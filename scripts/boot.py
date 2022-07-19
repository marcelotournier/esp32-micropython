"""
This file is executed on every boot
(including wake-boot from deepsleep)

"""
import esp
import webrepl
import network


# Deactivating debug mode
esp.osdebug(None)

# Starting webREPL
webrepl.start()

# Connect to SSID during boot:
AP = "my_wifi_network"
PASS = "123123"

sta_if = network.WLAN(network.STA_IF); sta_if.active(True)
sta_if.scan() # Scan for available access points
sta_if.connect(SSID, PASS) # Connect to SSID
sta_if.isconnected()
