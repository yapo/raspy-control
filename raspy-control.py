import RPi.GPIO as GPIO
import time, signal, os

def signal_handler(signal, frame):
	global Loop
	Loop = False

# - - - - - - - - - - - - - - - - -

Loop=True
Pin=4
Pout=17
blink=False
cmd='/home/devel/github/raspy-control/raspy-control.sh poweroff'

GPIO.setmode(GPIO.BCM)
GPIO.setup(Pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(Pout, GPIO.OUT)
signal.signal(signal.SIGTERM, signal_handler)

while Loop:
	GPIO.output(Pout, blink)
	blink = not blink
	if (GPIO.input(Pin) == GPIO.LOW):
		print "Tilt!"
		GPIO.output(Pout, False)
		os.system(cmd)
		Loop=False
	time.sleep(0.5)
GPIO.cleanup()

