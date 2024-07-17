@echo off
setlocal enabledelayedexpansion
echo>tmp.txt
set /A xxx = 10
for /l %%x in (1, 1, 3000) do (
	echo Loop%%x >> tmp.txt
	if %xxx% == 10 (.\adb -s emulator-5558 shell input touchscreen tap 300 2300)
	timeout 4
	.\adb -s emulator-5558 shell screencap -p /sdcard/screen.png
	.\adb -s emulator-5558 pull /sdcard/screen.png ./tmp/%%x.png
	copy .\tmp\%%x.png F:\Shites\
	magick convert F:/Shites/%%x.png -crop 535x71+483+1293 F:/Shites/c%%x.png
	magick convert F:/Shites/%%x.png -crop 72x36+477+1118 -set colorspace Gray -separate -average -brightness-contrast 0x10 F:/Shites/l%%x.png
	py identifier.py F:/Shites/c%%x.png F:/Shites/l%%x.png > tmpx.txt
	set /p T=<tmpx.txt
	echo :-!T!-:
	set %xxx% = 10
	if !T! == True (
		.\adb -s emulator-5558 shell input touchscreen tap 800 2300
		timeout 1
		.\adb -s emulator-5558 shell input touchscreen tap 800 1700
		set %xxx% = 0
		)
	)
pause