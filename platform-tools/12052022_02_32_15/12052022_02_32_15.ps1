$UBAsQHnl99 = .\adb devices
function cockpit {
.\adb -s emulator-5554 shell screencap -p /sdcard/rson.png
.\adb -s emulator-5554 pull /sdcard/rson.png ./tmp/rson.png | Out-Null
magick convert ./tmp/rson.png -crop 247x38+240+24 .\tmp\rsonx.png
magick convert ./tmp/rson.png -crop 161x30+280+1209 .\tmp\rsony.png
$textt= (py captioner.py .\tmp\rsonx.png ) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
$gKeANwVu99= (py captioner.py .\tmp\rsony.png )
echo $textt >> logs.txt
if( (!$textt.Contains('War')) -or (!$gKeANwVu99.Contains('attle')) ){
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
$lruGNfFq99 = 264,339,414
$PMpJSltG99 = 1150,652
$ic = 0
$xxx = Get-Random(2)
while ($true) {
echo 'chking if right screen'
cockpit
echo 'beginning next loop'
.\adb -s emulator-5554 shell screencap -p /sdcard/screen.png
.\adb -s emulator-5554 pull /sdcard/screen.png ./Rallyshite/snaps/screen.png | Out-Null
$coord=[int] (py tester.py .\Rallyshite\snaps\screen.png .\Rallyshite\greenjoin.png) <# to get some debug output tryremoving '[int]' , which makes $coord reference to function#>
$zoteQPAZ99 = $coord + 47
if ($zoteQPAZ99 -eq 47){
echo 'Not Joined , no rally , swiping nd chking'
$xxx = Get-Random(2)
.\adb -s emulator-5554 shell input swipe 415 $PMpJSltG99[$xxx] 415 $PMpJSltG99[1-$xxx]
timeout 3 | Out-Null
continue
}
$lYqkonNL99 = $zoteQPAZ99 - 12
$LHUcrjaB99 = $zoteQPAZ99 - 175
$cMbSrOOJ99 = $coord - 319
magick convert ./Rallyshite/snaps/screen.png -crop 90x22+565+$zoteQPAZ99 ./Rallyshite/marchTime.png
magick convert ./Rallyshite/snaps/screen.png -crop 116x30+212+$lYqkonNL99 ./Rallyshite/rallyTime.png
magick convert ./Rallyshite/snaps/screen.png -crop 210x33+472+$LHUcrjaB99 ./Rallyshite/monCap.png
$YON=py captioner.py ./Rallyshite/marchTime.png
$YON2=py captioner.py ./Rallyshite/rallyTime.png
$HMSJDfiW99 = py captioner.py ./Rallyshite/monCap.png
if (($HMSJDfiW99.contains('unior'))    ){
echo $HMSJDfiW99
echo 'Weakling , inefficient junior monster'
.\adb -s emulator-5554 shell input swipe 415 $PMpJSltG99[$xxx] 415 $PMpJSltG99[1-$xxx]
continue}
$AdpsBVcO99=[int]$YON.Split(':')[-1] + 60*[int]$YON.Split(':')[-2] + 12
$uKSQVyXR99=[int]$YON2.Split(':')[-1] + 60*[int]$YON2.Split(':')[-2]
if (($AdpsBVcO99 -lt $uKSQVyXR99) -and ($uKSQVyXR99 -lt 301)){
.\adb -s emulator-5554 shell input touchscreen tap 466 ($zoteQPAZ99 -47)
start-sleep 1.5 | Out-Null
.\adb -s emulator-5554 shell screencap -p /sdcard/monPow-5554.png
.\adb -s emulator-5554 pull /sdcard/monPow-5554.png ./tmp/monPow-5554.png | Out-Null
magick convert .\tmp\monPow-5554.png -crop 124x33+547+120 ./Rallyshite/monpow-5554.png
[int]$mRgnckzY99 = (py captioner.py ./Rallyshite/monpow-5554.png).Split('M')[0]
if ($mRgnckzY99 -lt 69){
echo 'weakling'
.\adb -s emulator-5554 shell input keyevent 4
$xxx = Get-Random(2)
.\adb -s emulator-5554 shell input swipe 415 $PMpJSltG99[$xxx] 415 $PMpJSltG99[1-$xxx]
continue}
.\adb -s emulator-5554 shell input touchscreen tap 365 1219
timeout 2 | Out-Null
.\adb -s emulator-5554 shell screencap -p /sdcard/jorNot.png
.\adb -s emulator-5554 pull /sdcard/jorNot.png ./Rallyshite/snaps/jorNot.png | Out-Null
magick convert ./Rallyshite/snaps/jorNot.png -crop 100x50+156+1205 ./Rallyshite/jorNotX.png
$nmUnlgnZ99 = [string](py captioner.py ./Rallyshite/jorNotX.png)
if (!$nmUnlgnZ99.Contains('es')){
echo  'Probably out of marches , going back to Alliance War tab'
.\adb -s emulator-5554 shell input keyevent 4
timeout 1 | Out-Null
$xxx = Get-Random(2)
.\adb -s emulator-5554 shell input swipe 415 $PMpJSltG99[$xxx] 415 $PMpJSltG99[1-$xxx]
timeout 2 | Out-Null
continue
}
timeout 1 | Out-Null
.\adb -s emulator-5554 shell input touchscreen tap $lruGNfFq99[$ic%3] 145
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
$eodnMtGV99 = py captioner.py ./Rallyshite/stamCon.png
if (  ( $eodnMtGV99 -ne $null) -and ($eodnMtGV99.Contains('rm'))  ){
.\adb -s emulator-5554 shell input touchscreen tap 474 756
.\adb -s emulator-5554 shell input swipe 384 1106 384 735
timeout 2 | Out-Null <# gap to compensate for swipe#>
.\adb -s emulator-5554 shell screencap -p /sdcard/stamScreen.png  
.\adb -s emulator-5554 pull /sdcard/stamScreen.png ./Rallyshite/stamScreen.png | Out-Null
$VtOHeWpq99 = [int] (py tester.py .\Rallyshite\stamScreen.png .\Rallyshite\stam_100.png)
$VtOHeWpq99+=90
.\adb -s emulator-5554 shell input touchscreen tap 625 $VtOHeWpq99 <#Use button#>
.\adb -s emulator-5554 shell input touchscreen tap 598.7 679	<# + button#>
.\adb -s emulator-5554 shell input touchscreen tap 507 917	<#Ok on use stam screen button#>
timeout 2 | Out-Null										<#Progress loader after using stams#>
