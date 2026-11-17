print("Hello, World!")
from machine import Pin
import time

# Onboard User LED is connected to GPIO 21 (active-low)
led = Pin(21, Pin.OUT)

while True:
    led.value(0)  # Turn LED ON
    time.sleep(0.5)
    led.value(1)  # Turn LED OFF
    time.sleep(0.5)

# the end goal of this is to talk over TBD (CAN likely) with central control to implement the following calls:
# - set_speed(left_speed, right_speed)
# - get_speed() -> (left_speed, right_speed)
# - stop()
