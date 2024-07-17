while ($true){

.\adb -s emulator-5554 shell input touchscreen tap 210 1228

Start-Sleep 2.1

.\adb -s emulator-5554 shell input touchscreen tap 360 816
}