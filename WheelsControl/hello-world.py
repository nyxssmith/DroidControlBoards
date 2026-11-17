from machine import UART
import time

# Initialize UART(1) on XIAO ESP32S3
# D6 corresponds to GPIO 43 (TX) and D7 corresponds to GPIO 44 (RX)
uart = UART(1, baudrate=9600, tx=43, rx=44, bits=8, parity=None, stop=1)

print("UART initialized. Sending periodic messages...")

while True:
    message = b"Hello from XIAO ESP32S3 RS485!\r\n"
    message = b"TEST\r\n"
    uart.write(message)
    print("Sent:", message)
    
    # Wait 2 seconds before sending the next packet
    time.sleep(2)