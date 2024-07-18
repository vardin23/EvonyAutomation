echo '.' > logs-5564.txt
function rsonchk {
	.\adb -s emulator-5564 shell screencap -p /sdcard/rson-5564.png
	.\adb -s emulator-5564 pull /sdcard/rson-5564.png ./tmp/rson-5564.png | Out-Null
	magick convert ./tmp/rson-5564.png -crop 247x38+240+24 .\tmp\rsonx-5564.png
	$textt= (py captioner.py .\tmp\rsonx-5564.png ) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
	magick convert ./tmp/rson-5564.png -crop 161x30+280+1209 .\tmp\rsony-5564.png
	$textt2= (py captioner.py .\tmp\rsony-5564.png )
	echo $textt >> logs.txt
	if( (!$textt.Contains('War')) -or (!$textt2.Contains('attle')) ){
		echo 'Not correct screen , correcting now'
		.\adb -s emulator-5564 shell input keyevent 4
		.\adb -s emulator-5564 shell input keyevent 4
		.\adb -s emulator-5564 shell input keyevent 4
		.\adb -s emulator-5564 shell input keyevent 4
		.\adb -s emulator-5564 shell input keyevent 4
		.\adb -s emulator-5564 shell input keyevent 4
		timeout 2 | Out-Null
		.\adb -s emulator-5564 shell screencap -p /sdcard/coq-5564.png
		.\adb -s emulator-5564 pull /sdcard/coq-5564.png ./tmp/coq-5564.png | Out-Null
		magick convert ./tmp/coq-5564.png -crop 117x30+182+742 .\tmp\coqx-5564.png
		$coq = py captioner.py .\tmp\coqx-5564.png
		echo $coq >> logs.txt
		if ($coq.Contains('nce')){.\adb -s emulator-5564 shell input keyevent 4}
		.\adb -s emulator-5564 shell input touchscreen tap 654 975
		start-sleep 0.75
		.\adb -s emulator-5564 shell input touchscreen tap 196 715
}}
	## Gen finder
	
function genfinder{
	
	.\adb -s emulator-5564 shell screencap -p /sdcard/gen-5564.png
	.\adb -s emulator-5564 pull /sdcard/gen-5564.png ./tmp/gen-5564.png | Out-Null
	magick convert ./tmp/gen-5564.png -crop 290*33+241+307 .\tmp\gen-5564.png
	$textt= (py captioner.py .\tmp\gen-5564.png )
	if (($textt.Contains('elec'))){
		.\adb -s emulator-5564 shell input touchscreen tap 116 660
		
		$x = 1
		while($x -lt 10){
		.\adb -s emulator-5554 shell input swipe 300 950 300 450 125
		Start-Job -ScriptBlock {
		start-sleep -ms 90
		.\adb -s emulator-5554 shell input tap 340 40
		}
		.\adb -s emulator-5554 shell input swipe 300 700 300 699 450
		remove-job -state 'Completed'
		.\adb -s emulator-5554 shell screencap -p /sdcard/curgen-5554.png
		.\adb -s emulator-5554 pull /sdcard/curgen-5554.png ./tmp/curgen-5554.png | Out-Null
		
		[string] $baib =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genBaib.png
		[string] $cleo = py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genCleo.png
		[string] $nath =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genNath.png
		[string] $nathSpec =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genNathSpec.png
		[string] $baibunsp = py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genBaibUnspec.png
		
		if ($baib -ne $null){$baibY = ([int]$baib.Split(',')[1] + 24) ;echo 'selecting',$baibY;.\adb -s emulator-5554 shell input touchscreen tap 625 $baibY}
		if ($baibunsp -ne $null){$baibY = ([int]$baibunsp.Split(',')[1] + 25) ;echo 'selecting',$baibY;.\adb -s emulator-5554 shell input touchscreen tap 625 $baibY}
		echo $baib , $cleo , $nath , $nathSpec , $baibunsp
		#read-host "Press ENTER to continue..."
		$x = $x + 1
}
		if ($x -eq 10){.\adb -s emulator-5564 shell input keyevent 4}
		else {
			.\adb -s emulator-5564 shell input touchscreen tap 116 860
			
			while($x -lt 12){
				.\adb -s emulator-5554 shell input swipe 300 950 300 450 125
				Start-Job -ScriptBlock {
				start-sleep -ms 90
				.\adb -s emulator-5554 shell input tap 340 40
				}
				.\adb -s emulator-5554 shell input swipe 300 700 300 699 450
				remove-job -state 'Completed'
				.\adb -s emulator-5554 shell screencap -p /sdcard/curgen-5554.png
				.\adb -s emulator-5554 pull /sdcard/curgen-5554.png ./tmp/curgen-5554.png | Out-Null
				
				[string] $baib =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genBaib.png
				[string] $cleo = py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genCleo.png
				[string] $nath =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genNath.png
				[string] $nathSpec =py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genNathSpec.png
				[string] $baibunsp = py locFinder.py .\tmp\curgen-5554.png .\EvonyImgs\genBaibUnspec.png
				
				if ($nath -ne $null){$nathY = ([int]$nath.Split(',')[1] + 24) ;echo 'selecting',$nathY;.\adb -s emulator-5554 shell input touchscreen tap 625 $nathY}
				if ($nathSpec -ne $null){$nathY = ([int]$nathSpec.Split(',')[1] + 24) ;echo 'selecting',$nathY;.\adb -s emulator-5554 shell input touchscreen tap 625 $nathY}	
			
		}
	
	}
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
	.\adb -s emulator-5564 shell screencap -p /sdcard/screen-5564.png
	.\adb -s emulator-5564 pull /sdcard/screen-5564.png ./tmp/screen-5564.png | Out-Null
	copy .\tmp\screen-5564.png F:\Rallyshite\instance-5564\screen.png
	$coord=[int] (py tester.py F:\Rallyshite\instance-5564\screen.png .\greenjoin.png) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
	$coordY = $coord + 47
	if ($coordY -eq 47){
		echo 'NotJoined , no rally , swiping'
		$xxx = Get-Random(2)
		.\adb -s emulator-5564 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		timeout 3 | Out-Null
		continue
	}
	$coordremTime = $coordY - 12
	$moncord = $coordY - 175
	magick convert F:/Rallyshite/instance-5564/screen.png -crop 90x22+565+$coordY F:/Rallyshite/instance-5564/marchTime.png
	magick convert F:/Rallyshite/instance-5564/screen.png -crop 116x30+212+$coordremTime F:/Rallyshite/instance-5564/rallyTime.png
	magick convert F:/Rallyshite/instance-5564/screen.png -crop 210x33+472+$moncord F:/Rallyshite/instance-5564/monCap.png
	$YON=py captioner.py F:/Rallyshite/instance-5564/marchTime.png
	$YON2=py captioner.py F:/Rallyshite/instance-5564/rallyTime.png
	$monsName = py captioner.py F:/Rallyshite/instance-5564/monCap.png
	
	##monster choice
	if (($monsName.contains('unior'))  ){
		echo $monsName
		echo 'Junior Shite'
		.\adb -s emulator-5564 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		continue}
	###/end
	
	$marchTime=[int]$YON.Split(':')[-1] + 60*[int]$YON.Split(':')[-2] + 9
	$rallyTime=[int]$YON2.Split(':')[-1] + 60*[int]$YON2.Split(':')[-2]
	if (($marchTime -lt $rallyTime) -and ($rallyTime -lt 301)){
	.\adb -s emulator-5564 shell input touchscreen tap 466 ($coordY - 47)
	start-sleep 1.5 | Out-Null
	
	.\adb -s emulator-5564 shell screencap -p /sdcard/monPow.png
	.\adb -s emulator-5564 pull /sdcard/monPow.png ./tmp/monPow.png | Out-Null
	magick convert .\tmp\monPow.png -crop 124x33+547+120 F:/Rallyshite/monpow.png
	[int]$monsPower = (py captioner.py F:/Rallyshite/monpow.png).Split('M')[0]
	if ($monsPower -lt 69){
		echo 'weakfck'
		.\adb -s emulator-5564 shell input keyevent 4
		$xxx = Get-Random(2)
		.\adb -s emulator-5564 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		continue}
	
	echo 'tapping 365 1219'
	.\adb -s emulator-5564 shell input touchscreen tap 365 1219
	timeout 2 | Out-Null
	.\adb -s emulator-5564 shell screencap -p /sdcard/jorNot.png
	.\adb -s emulator-5564 pull /sdcard/jorNot.png ./tmp/instance-5564/jorNot.png | Out-Null
	copy .\tmp\instance-5564\jorNot.png F:\Rallyshite\instance-5564\jorNot.png
	magick convert F:/Rallyshite/instance-5564/jorNot.png -crop 100x50+156+1205 F:/Rallyshite/instance-5564/jorNotX.png
	$jorNot = [string](py captioner.py F:/Rallyshite/instance-5564/jorNotX.png)
	if (!$jornot.Contains('es')){
		echo  'Out of Marches probably , going back and swiping'
		.\adb -s emulator-5564 shell input keyevent 4
		timeout 1 | Out-Null
		$xxx = Get-Random(2)
		.\adb -s emulator-5564 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
		timeout 2 | Out-Null
		continue
		
	}
	timeout 1 | Out-Null
	.\adb -s emulator-5564 shell input touchscreen tap $presets[$ic%3] 145
	
	#genfinder
	
	.\adb -s emulator-5564 shell input touchscreen tap 537 1225
	timeout 1 | Out-Null
	.\adb -s emulator-5564 shell screencap -p /sdcard/stam-5564.png
	.\adb -s emulator-5564 pull /sdcard/stam-5564.png ./tmp/stam-5564.png | Out-Null
	copy .\tmp\stam-5564.png F:\Rallyshite\instance-5564\stam.png
	magick convert F:/Rallyshite/instance-5564/stam.png -crop 114x38+421+737 F:/Rallyshite/instance-5564/stamCon.png
	$stamNeeded = py captioner.py F:/Rallyshite/instance-5564/stamCon.png
	if (  ( $stamNeeded -ne $null) -and ($stamNeeded.Contains('rm'))  ){
		.\adb -s emulator-5564 shell input touchscreen tap 474 756
		.\adb -s emulator-5564 shell input swipe 384 1106 384 735
		timeout 2 | Out-Null <# gap to compensate for swipe#>
		.\adb -s emulator-5564 shell screencap -p /sdcard/stamScreen-5564.png  
		.\adb -s emulator-5564 pull /sdcard/stamScreen-5564.png ./tmp/stamScreen-5564.png | Out-Null
		copy .\tmp\stamScreen-5564.png F:\Rallyshite\instance-5564\stamScreen.png
		$stamButton = [int] (py tester.py F:\Rallyshite\instance-5564\stamScreen.png stam_100.png)
		$stamButton+=90
		.\adb -s emulator-5564 shell input touchscreen tap 625 $stamButton <#Use button#>
		.\adb -s emulator-5564 shell input touchscreen tap 598.7 679	<# + button#>
		.\adb -s emulator-5564 shell input touchscreen tap 507 917	<#Ok on use stam screen button#>
		timeout 2 | Out-Null										<#Progress loader after using stams#>
		<#.\adb -s emulator-5564 shell input touchscreen tap 45 55#>
		echo 'Tried using 1 stam , going bck'
		.\adb -s emulator-5564 shell input keyevent 4 <#  back after using stam  #>
		timeout 2 | Out-Null
		.\adb -s emulator-5564 shell input touchscreen tap 537 1225	<#  Join button  #>
		
	}
	$ic+=1
	echo 'Joined'}
	else {
		echo 'Too Long ,\n March Time : '$marchTime 'rallyTime : '$rallyTime }
	$xxx = Get-Random(2)
	<#.\adb -s emulator-5564 shell input touchscreen tap 660 974#>
	<#.\adb -s emulator-5564 shell input touchscreen tap 445 717#>
	echo 'swiping before next main rlly screen'
	.\adb -s emulator-5564 shell input swipe 415 $swiper[$xxx] 415 $swiper[1-$xxx]
	timeout 2 | Out-Null
	}