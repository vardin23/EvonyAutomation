
function rsonchk {
	.\adb -s emulator-5554 shell screencap -p /sdcard/rson.png
	.\adb -s emulator-5554 pull /sdcard/rson.png ./tmp/rson.png | Out-Null
	magick convert ./tmp/rson.png -crop 247x38+240+24 .\tmp\rsonx.png
	magick convert ./tmp/rson.png -crop 161x30+280+1209 .\tmp\rsony.png
	$textt= (py captioner.py .\tmp\rsonx.png ) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
	$textt2= (py captioner.py .\tmp\rsony.png )
	echo $textt >> logs.txt
	if( (!$textt.Contains('War')) -or (!$textt2.Contains('attle')) ){
		echo 'Not correct screen , correcting now'
		.\adb -s emulator-5554 shell input keyevent 4
		.\adb -s emulator-5554 shell input keyevent 4
		.\adb -s emulator-5554 shell input keyevent 4
		.\adb -s emulator-5554 shell input keyevent 4
		.\adb -s emulator-5554 shell input keyevent 4
		.\adb -s emulator-5554 shell input keyevent 4
		timeout 2 | Out-Null
		.\adb -s emulator-5554 shell screencap -p /sdcard/coq.png
		.\adb -s emulator-5554 pull /sdcard/coq.png ./tmp/coq.png | Out-Null
		magick convert ./tmp/coq.png -crop 117x30+182+742 .\tmp\coqx.png
		$coq = py captioner.py .\tmp\coqx.png
		echo $coq >> logs.txt
		if ($coq.Contains('nce')){.\adb -s emulator-5554 shell input keyevent 4}
		.\adb -s emulator-5554 shell input touchscreen tap 654 975
		start-sleep 0.75
		.\adb -s emulator-5554 shell input touchscreen tap 196 715
	}
	
}


$presets = 264,339,414
$swiper = 1150,652
$ic = 0
$xxx = Get-Random(2)
while ($true) {
	echo 'chking if right screen'
	rsonchk
	echo 'beginning next loop'

	.\adb -s emulator-5554 shell screencap -p /sdcard/screen.png
	.\adb -s emulator-5554 pull /sdcard/screen.png ./Rallyshite/snaps/screen.png | Out-Null
	$coord=[int] (py tester.py .\Rallyshite\snaps\screen.png .\Rallyshite\greenjoin.png) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
	$coordY = $coord + 47
	if ($coordY -eq 47){
		echo 'Nothing joined , checking again'
		$xxx = Get-Random(2)
		.\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		timeout 3 | Out-Null
		continue
	}
	$coordremTime = $coordY - 12
	$moncord = $coordY - 175
	$monpCord = $coord - 319
	magick convert ./Rallyshite/snaps/screen.png -crop 90x22+565+$coordY ./Rallyshite/marchTime.png
	magick convert ./Rallyshite/snaps/screen.png -crop 116x30+212+$coordremTime ./Rallyshite/rallyTime.png
	magick convert ./Rallyshite/snaps/screen.png -crop 210x33+472+$moncord ./Rallyshite/monCap.png
	$YON=py captioner.py ./Rallyshite/marchTime.png
	$YON2=py captioner.py ./Rallyshite/rallyTime.png
	$monsName = py captioner.py ./Rallyshite/monCap.png
	if (($monsName.contains('unior'))    ){
		echo $monsName
		echo 'Weakling , inefficient junior monster'
		.\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		continue}
	
	$marchTime=[int]$YON.Split(':')[-1] + 60*[int]$YON.Split(':')[-2] + 12
	$rallyTime=[int]$YON2.Split(':')[-1] + 60*[int]$YON2.Split(':')[-2]
	if (($marchTime -lt $rallyTime) -and ($rallyTime -lt 301)){
	.\adb -s emulator-5554 shell input touchscreen tap 466 ($coordY -47)
	start-sleep 1.5 | Out-Null
	
	.\adb -s emulator-5554 shell screencap -p /sdcard/monPow-5554.png
	.\adb -s emulator-5554 pull /sdcard/monPow-5554.png ./tmp/monPow-5554.png | Out-Null
	magick convert .\tmp\monPow-5554.png -crop 124x33+547+120 ./Rallyshite/monpow-5554.png
	[int]$monsPower = (py captioner.py ./Rallyshite/monpow-5554.png).Split('M')[0]
	if ($monsPower -lt 69){
		echo 'weakling'
		.\adb -s emulator-5554 shell input keyevent 4
		$xxx = Get-Random(2)
		.\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		continue}
	
	#echo 'tapping 365 1219'
	
	
	
	.\adb -s emulator-5554 shell input touchscreen tap 365 1219
	timeout 2 | Out-Null
	.\adb -s emulator-5554 shell screencap -p /sdcard/jorNot.png
	.\adb -s emulator-5554 pull /sdcard/jorNot.png ./Rallyshite/snaps/jorNot.png | Out-Null
	magick convert ./Rallyshite/snaps/jorNot.png -crop 100x50+156+1205 ./Rallyshite/jorNotX.png
	$jorNot = [string](py captioner.py ./Rallyshite/jorNotX.png)
	if (!$jornot.Contains('es')){
		echo  'Probably out of marches , going back to Alliance War tab'
		.\adb -s emulator-5554 shell input keyevent 4
		timeout 1 | Out-Null
		$xxx = Get-Random(2)
		.\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		timeout 2 | Out-Null
		continue
		
	}
	timeout 1 | Out-Null
	.\adb -s emulator-5554 shell input touchscreen tap $presets[$ic%3] 145
	for ($i =0 ; $i -lt 6 ; $i++){
    .\adb -s emulator-5554 shell input touchscreen swipe 493 960 493 500}
	.\adb -s emulator-5554 shell input touchscreen tap 261 1240
	start-sleep 0.5
	.\adb -s emulator-5554 shell input touchscreen tap 492 800
	.\adb -s emulator-5554 shell input touchscreen tap 537 1225
	timeout 1 | Out-Null
	.\adb -s emulator-5554 shell screencap -p /sdcard/stam.png
	.\adb -s emulator-5554 pull /sdcard/stam.png ./tmp/stam.png | Out-Null
	copy .\tmp\stam.png .\Rallyshite\stam.png
	magick convert ./Rallyshite/stam.png -crop 114x38+421+737 ./Rallyshite/stamCon.png
	$stamNeeded = py captioner.py ./Rallyshite/stamCon.png
	if (  ( $stamNeeded -ne $null) -and ($stamNeeded.Contains('rm'))  ){
		.\adb -s emulator-5554 shell input touchscreen tap 474 756
		.\adb -s emulator-5554 shell input swipe 384 1106 384 735
		timeout 2 | Out-Null <# gap to compensate for swipe#>
		.\adb -s emulator-5554 shell screencap -p /sdcard/stamScreen.png  
		.\adb -s emulator-5554 pull /sdcard/stamScreen.png ./Rallyshite/stamScreen.png | Out-Null
		$stamButton = [int] (py tester.py .\Rallyshite\stamScreen.png .\Rallyshite\stam_100.png)
		$stamButton+=90
		.\adb -s emulator-5554 shell input touchscreen tap 625 $stamButton <#Use button#>
		.\adb -s emulator-5554 shell input touchscreen tap 598.7 679	<# + button#>
		.\adb -s emulator-5554 shell input touchscreen tap 507 917	<#Ok on use stam screen button#>
		timeout 2 | Out-Null										<#Progress loader after using stams#>
		<#.\adb -s emulator-5554 shell input touchscreen tap 45 55#>
		echo 'Tried consuming 2*100 stams , going bck now'
		.\adb -s emulator-5554 shell input keyevent 4 <#  back after using stam  #>
		timeout 1 | Out-Null
		.\adb -s emulator-5554 shell input touchscreen tap 537 1225	<#  Join button  #>
		
	}
	$ic+=1
	echo 'Joined a rally'}
	else {
		echo ' March time to rallier too long ,`n March Time : '$marchTime 'RallyTime : '$rallyTime }
	$xxx = Get-Random(2)
	start-sleep(0.75)
	<#.\adb -s emulator-5554 shell input touchscreen tap 660 974#>
	<#.\adb -s emulator-5554 shell input touchscreen tap 445 717#>
	echo 'swiping before next main rlly screen'
	.\adb -s emulator-5554 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
	start-sleep(0.75)
	}
