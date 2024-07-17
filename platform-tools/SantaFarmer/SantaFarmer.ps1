$xs = (150 , 570)
$ys = (800 , 500)

$instx = 'emulator-5554'

function screenSnap([string]$one){
		..\adb -s $instx shell screencap -p /sdcard/$one
		..\adb -s $instx pull /sdcard/$one ../tmp/
		$one | Out-Null
		
	
}

while($true){

..\adb -s $instx shell input swipe 360 640 $xs[(get-random 2)] $ys[(get-random 2)]
start-sleep 1.3
screenSnap santasnap-$instX.png
[string]$coords = py locFinder.py ..\tmp\santasnap-$instX.png santa.png
echo 'coords:'$coords
$cX = [int]$coords.Split(',')[0] + 15
$cY = [int]$coords.Split(',')[1] + 35
if($cX -eq 15){continue}
if($cY -eq 35){continue}
..\adb -s $instx shell input touchscreen tap $cX $cY
start-sleep 0.7
screenSnap santasnap2-$instX.png
#timeout 10 #to test only
[string]$mainVisBut = py locFinder.py ..\tmp\santasnap2-$instX.png visitMain.jpg
$mvX = [int]$mainVisBut.Split(',')[0] + 10
$mvY = [int]$mainVisBut.Split(',')[1] + 10
if($mvX -eq 10 -or $mvY -eq 10){..\adb -s $instx shell input keyevent 4;continue}
..\adb -s $instx shell input touchscreen tap $mvX $mvY
start-sleep 0.3
screenSnap santasnap3-$instX.png
$visitONot = py locFinder.py ..\tmp\santasnap3-$instX.png visit.jpg
$visitONot = $visitONot.Split(',')[0]
$smh = 0
echo 'visitoNot'$visitONot
while ($visitONot -ne 0 -and $smh -le 3){
	echo 'here'
	start-sleep 0.5
	..\adb -s $instx shell input touchscreen tap 352 893
	start-sleep 0.25
	screenSnap santasnap3-$instX.png
	$visitONot = py locFinder.py ..\tmp\santasnap3-$instX.png visit.jpg
	$visitONot = $visitONot.Split(',')[0]
	$smh++
	echo 'left'
	
}
if($smh -ge 3){echo 'going bck' ; ..\adb -s $instx shell input keyevent 4}
}