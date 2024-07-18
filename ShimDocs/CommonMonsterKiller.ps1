echo 'Hey'
$ore_tile = @(0)*5
$lumb_tile= @(0)*5
$stone_tile = @(0)*5
$food_tile= @(0)*5
$initials = (611,602) , (564,663) , (408,469) , (319,648)
while ($true) {
	$y = 'ore_tile.jpg','lumb_tile.jpg','food_tile.jpg'
	..\adb -s emulator-5554 shell input tap 244 1128
	..\adb -s emulator-5554 shell input tap 256 700
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	$xxx= Get-Random(4)
	$rand = Get-Random(75)
	..\adb -s emulator-5554 shell input text ($initials[$xxx][0] + $rand)
	timeout 3
	..\adb -s emulator-5554 shell input tap 519 700
	..\adb -s emulator-5554 shell input tap 519 700
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	..\adb -s emulator-5554 shell input keyevent 67
	$rand = Get-Random(75)
	..\adb -s emulator-5554 shell input text ($initials[$xxx][1] + $rand)
	timeout 3
	..\adb -s emulator-5554 shell input tap 350 806
	..\adb -s emulator-5554 shell input tap 350 806 <#Go Button#>
	timeout 2
	..\adb -s emulator-5554 shell screencap -p /sdcard/screen.png
	..\adb -s emulator-5554 pull /sdcard/screen.png ./tmp/screen.png | Out-Null
	copy ./tmp/screen.png F:/farmShite/screen.png												
	if ($ore_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "ore_tile.jpg" } }
	if ($food_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "food_tile.jpg" } }
	if ($lumb_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "lumb_tile.jpg" } }
	if ($stone_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "stone_tile.jpg" } }

	foreach ($x in $y){
		
		[string]$coord=(py locFinder.py F:\farmShite\screen.png $x) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
		echo 'coord - $coord'
		$cX = [int]$coord.Split(',')[0] + 20
		$cY = [int]$coord.Split(',')[1] + 10
		if (($cX -eq 20) -or ($cY  -eq  10)){continue}
		..\adb -s emulator-5554 shell input tap ($cX) ($cY)
		timeout 2
		..\adb -s emulator-5554 shell screencap -p /sdcard/screen.png
		..\adb -s emulator-5554 pull /sdcard/screen.png ./tmp/screen.png | Out-Null
		copy .\tmp\screen.png F:\farmShite\screen.png
		[string]$occ_Loc = py locFinder.py F:\farmShite\screen.png occupy.jpg
		$occ_X = [int]$occ_Loc.Split(',')[0]
		$occ_Y = [int]$occ_Loc.Split(',')[1]
		if(($occ_X  -eq  0) -or ($occ_Y -eq 0)){
			continue}
		..\adb -s emulator-5554 shell input tap ($occ_X) ($occ_Y)
		<#gennSearchToBeDone#>
		timeout 2
		..\adb -s emulator-5554 shell input tap 531 1233
		Switch -exact ($x)
		{
			'ore_tile.jpg' {
					$ore_tile[0] = $cX
					$ore_tile[1] = $cY
					$ore_tile[4] = $ore_tile[4] + 1
					break
				
				}
			'stone_tile.jpg' {
				$stone_tile[0] = $cX
				$stone_tile[1] = $cY
				$stone_tile[4] = $stone_tile[4] + 1
				break
			}
			'food_tile.jpg' {
				$food_tile[0] = $cX
				$food_tile[1] = $cY
				$food_tile[4] = $food_tile[4] + 1
				break
			}
			'lumb_tile.jpg' {
				$lumb_tile[0] = $cX
				$lumb_tile[1] = $cY
				$lumb_tile[4] = $lumb_tile[4] + 1
				break
			}
		
		}
	 }
	}	
		<#
	if ($coordY -eq 47){
		echo 'NotJoined , no rally'
		$xxx = Get-Random(2)
		..\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		timeout 3 | Out-Null
		continue
	}#>