import RPi.GPIO as GPIO
import time

Loop=True
Pin=4
Pout=17
blink=False

GPIO.setmode(GPIO.BCM)
GPIO.setup(Pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(Pout, GPIO.OUT)

while Loop:
	GPIO.output(Pout, blink)
	blink = not blink
	if (GPIO.input(Pin) == 0):
		print "Tilt!"
		Loop=False
	time.sleep(0.15)

print "Saliendo!"
GPIO.cleanup()
