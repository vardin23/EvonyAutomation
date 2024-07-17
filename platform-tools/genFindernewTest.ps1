$instx = 'emulator-5556'
function screenSnap([string]$one){
		.\adb -s $instx shell screencap -p /sdcard/$one
		.\adb -s $instx pull /sdcard/$one ./tmp/
		$one | Out-Null
	
}
$mainGen = 'none'

function mainHomeSeq{
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		start-sleep 0.5
		.\adb -s $instx shell screencap -p /sdcard/coq.png
		.\adb -s $instx pull /sdcard/coq.png ./tmp/coq$instx.png | Out-Null
		magick convert ./tmp/coq$instx.png -crop 117x30+182+742 .\tmp\coqx$instx.png
		$coq = py captioner.py .\tmp\coqx$instx.png
		#echo $coq >> logs.txt
		if ($coq.Contains('nce')){.\adb -s $instx shell input keyevent 4}
}


function farminGenfinder{
		#.\adb -s $instx shell input touchscreen tap 116 660   #for rallies
		.\adb -s $instx shell input touchscreen tap 116 324
		start-sleep 0.1
		.\adb -s $instx shell input touchscreen tap 360 145
		start-sleep 0.8
		screenSnap curgen-$instx.png
		$x = 1
		while($x -lt 6){
		#[string] $baib =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaib.png
		#[string] $cleo = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleo.png
		#[string] $cleounsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleoUnsp.png
		#[string] $nath =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNath.png
		#[string] $nathSpec =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNathSpec.png
		#[string] $baibunsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaibUnspec.png
		[string] $jind = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\jindeList.png
		[string] $marius = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\mariusList.png
		if ($jind-ne $null){$jindX = ([int]$jind.Split(',')[0]) ; $jindY = ([int]$jind.Split(',')[1]) ;echo 'selecting Jindeok' ; .\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; $mainGen='jindeok';break}
		if ($marius-ne $null){$jindX = ([int]$marius.Split(',')[0]) ; $jindY = ([int]$marius.Split(',')[1]) ;echo 'selecting marius' ; .\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; $mainGen='marius' ; break}
		.\adb -s $instx shell input touchscreen swipe 360 700 360 400 450
		start-sleep -ms 2
		screenSnap curgen-$instx.png
		#echo $baib , $cleo , $nath , $nathSpec , $baibunsp
		#read-host "Press ENTER to continue..."
		echo "Searching in progress"
		$x = $x + 1
}
		if ($x -eq 6){.\adb -s $instx shell input keyevent 4}
		else {
			timeout 3
			start-sleep 0.25
			#.\adb -s $instx shell input touchscreen tap 116 874		#asst gen selecting coord for monsters
			.\adb -s $instx shell input touchscreen tap 116 480
			start-sleep 0.1
			.\adb -s $instx shell input touchscreen tap 360 145
			start-sleep 0.8
			screenSnap curgen-$instx.png
			#while($sm -lt $quickSwipesAsst ){.\adb -s $instx shell input swipe 510 950 510 450 130;$sm++;start-sleep 0.3}
			while($x -lt 6){
				$sm = 0
				
			[string] $jind = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\jindeList.png
			[string] $marius = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\mariusList.png
			[string] $lucy = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\lucyList.png
			if ($jind-ne $null -and $mainGen -ne 'jindeok'){$jindX = ([int]$jind.Split(',')[0]) ; $jindY = ([int]$jind.Split(',')[1]) ;echo 'selecting Jindeok' ; .\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; break}
			if ($marius-ne $null -and $mainGen -ne 'marius'){$jindX = ([int]$marius.Split(',')[0]) ; $jindY = ([int]$marius.Split(',')[1]) ;echo 'selecting marius' ; .\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; break}
			if ($lucy-ne $null){$jindX = ([int]$lucy.Split(',')[0]) ; $jindY = ([int]$lucy.Split(',')[1]) ;echo 'selecting Lucy' ; .\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; break}
			.\adb -s $instx shell input touchscreen swipe 360 700 360 400 450
			start-sleep -ms 2
			screenSnap curgen-$instx.png
			#echo $baib , $cleo , $nath , $nathSpec , $baibunsp
			#read-host "Press ENTER to continue..."
			echo "Searching in progress"
			$x = $x + 1
			
		}
	
	}
	if ($x -ge 6){.\adb -s $instx shell input keyevent 4}
	
	
}

function toMainWorld{
	mainHomeSeq
	screenSnap keepOrWorld$instx.png
	$keepScrOrNot = py .\locFinder.py ./tmp/keepOrWorld$instx.png .\RallyShite\castle.png
	echo 'keepscr:'$keepScrOrNot
	if ($keepScrOrNot -eq $null){
	.\adb -s $instx shell input touchscreen tap 667 1207}
}


function fullSlotSleeper([int]$nMarches=5){
	
	toMainWorld
	screenSnap nMarchesUsed$instx.png
	magick convert ./tmp/nMarchesUsed$instx.png -crop 102x280+243+223 ./tmp/nMarchesUsed$instx.png
	$marchesNTimes = py captioner.py ./tmp/nMarchesUsed$instx.png
	$marchesNTimes = $marchesNTimes -replace '[^0-9:]'
	echo 'MarchesNTime:'$marchesNTimes
	if($marchesNTimes.Length -ge $nMarches){
		$i = 0
		$timeInSecs = @()
		while($i -lt $nMarches){
		$timeInSecs += ([int]$marchesNTimes[$i].Split(':')[0])*3600 + ([int]$marchesNTimes[$i].Split(':')[1])*60 + ([int]$marchesNTimes[$i].Split(':')[2])
		$i++
		}
	}
	echo 'TimeinSecsValue:'$timeInSecs
	$sleepTime = ($timeInSecs | Measure -minimum).Minimum
	echo 'sleeping for '$sleepTime 'in secs'
	start-sleep $sleepTime
	
}

#farminGenfinder
fullSlotSleeper