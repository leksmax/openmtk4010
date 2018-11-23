#coding: utf-8

import os, sys 
from time import sleep
from multiprocessing import Process, Queue

ON ='0'
OFF='1'

WIFI24='16'
WIFI50='17'
RRESET='19'
SYSTEM='81'

GPIO_FILE="/sys/devices/platform/10005000.pinctrl/mt_gpio"


LED_LIST=[WIFI24, WIFI50, SYSTEM]


def gpioModeSet(gpio, mode):
	commandStrings='echo mode ' + gpio + ' ' + mode + ' > ' + GPIO_FILE
	os.system(commandStrings)

def gpioDirectionSet(gpio, direct):
	commandStrings='echo dir ' + gpio + ' ' + direct + ' > ' + GPIO_FILE
	os.system(commandStrings)

def gpioOutSet(gpio, out):
	commandStrings='echo out ' + gpio + ' ' + out + ' > ' + GPIO_FILE
	os.system(commandStrings)


def device_get_interface_operstate(ifname):
	filename = '/sys/class/net/' + ifname + '/flags'
	try:
		with open(filename, 'r') as f:
			flags = int(f.read()[2:-1])
			if (flags % 2) == 1:
				return True
			else:
				return False
	except:
		return False

def blink(led, frequency):
	gpioOutSet(led, OFF)
	sleep(1.00/(2.0*frequency))
	gpioOutSet(led, ON) 
	sleep(1.00/(2.0*frequency))


def wifi24_led():
	while True:
		state = device_get_interface_operstate('ra0')
		if(state == False):
			gpioOutSet(WIFI24, OFF)
			sleep(1)
		elif(state == True):
			gpioOutSet(WIFI24, ON) 
			sleep(1)
		else:
			blink(WIFI24, 4)

def wifi50_led():
	while True:
		state = device_get_interface_operstate('rai0')
		if(state == False):
			gpioOutSet(WIFI50, OFF)
			sleep(1)
		elif(state == True):
			gpioOutSet(WIFI50, ON) 
			sleep(1)
		else:
			blink(WIFI50, 4)

def system_led():
	while True:
		if(os.system('pidof dockerd')):
			state = False
		else:
			state = True

		if(state == False):
			gpioOutSet(SYSTEM, OFF)
			sleep(1)
		elif(state == True):
			gpioOutSet(SYSTEM, ON) 
			sleep(1)
		else:
			blink(SYSTEM, 4)


if __name__ == '__main__':
	for gpio in LED_LIST:
		gpioModeSet(gpio, '1')
		gpioDirectionSet(gpio, '1')

	wifi24LEDProc = Process(target=wifi24_led) 
	wifi24LEDProc.daemon=True

	wifi50LEDProc = Process(target=wifi50_led) 
	wifi50LEDProc.daemon=True

	systemLEDProc = Process(target=system_led) 
	systemLEDProc.daemon=True

	wifi24LEDProc.start()
	wifi50LEDProc.start()
	systemLEDProc.start()

	wifi24LEDProc.join()
	wifi50LEDProc.join()
	systemLEDProc.join()

