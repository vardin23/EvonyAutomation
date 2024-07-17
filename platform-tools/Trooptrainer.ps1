$x = 0
while($x -le 1250) {
.\adb -s emulator-5564 shell input tap 513 1200
timeout 3
.\adb -s emulator-5564 shell input tap 513 1200
timeout 3
.\adb -s emulator-5564 shell input tap 513 1200
$x = $x + 1
timeout 7
}