$x = 0
while($x -le 95) {
.\adb -s emulator-5554 shell input tap 513 1200
timeout 3
.\adb -s emulator-5554 shell input tap 513 1200
timeout 3
.\adb -s emulator-5554 shell input tap 513 1200
$x = $x + 1
timeout 2
}