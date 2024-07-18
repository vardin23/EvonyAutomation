:loop

.\adb -s 1366443808000UI shell input touchscreen tap 624 1296
timeout 2
.\adb -s 1366443808000UI shell input touchscreen tap 467 949
timeout 1
.\adb -s 1366443808000UI shell input touchscreen tap 591 1776
timeout 1
.\adb -s 1366443808000UI shell input touchscreen tap 393 323
timeout 1
.\adb -s 1366443808000UI shell input touchscreen tap 900 2321
timeout 18

goto loop