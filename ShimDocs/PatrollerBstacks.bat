@echo off
setlocal enabledelayedexpansion
echo>tmp.txt
set /A xxx = 10
for /l %%x in (1, 1, 3000) do (
	echo Loop%%x >> tmp.txt
	if %xxx% == 10 (.\adb -s emulator-5554 shell input touchscreen tap 202 1213)
	timeout 5
	.\adb -s emulator-5554 shell screencap -p /sdcard/screen.png
	.\adb -s emulator-5554 pull /sdcard/screen.png ./tmp/%%x.png
	copy .\tmp\%%x.png F:\Shites\
	magick convert F:/Shites/%%x.png -crop 567x28+54+807 F:/Shites/c%%x.png
	magick convert F:/Shites/%%x.png -crop 54x25+316+687 F:/Shites/l%%x.png
	py identifier.py F:/Shites/c%%x.png F:/Shites/l%%x.png > tmpx.txt
	set /p T=<tmpx.txt
	echo :-!T!-:
	set %xxx% = 10
	if !T! == True (
		.\adb -s emulator-5554 shell input touchscreen tap 519 1230
		timeout 1
		.\adb -s emulator-5554 shell input touchscreen tap 519 998
		set %xxx% = 0
		)
	)
pause