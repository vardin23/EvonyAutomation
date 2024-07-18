::for /l %%x in (1, 1, 5) do (
::	.\adb shell input touchscreen tap 300 2300
::	.\adb shell screencap -p /sdcard/screen.png
::	.\adb pull /sdcard/screen.png /tmp/Shite.png
::	copy /tmp/Shite.png F:/Shites/%%x.png
::	)
::pause

:loop

adb -s 1366443808000UI shell input touchscreen tap 630 2322

goto loop