param([int]$oreMarches = 4,
	[int]$lumbMarches = 1,
	[int]$foodMarches = 0,
	[int]$stoneMarches = 0

)
$host.ui.RawUI.WindowTitle = 'DisOVFarmer'
$presets = 72,152,242,312,392
 $ldDir = "F:\SteamLibrary\LDPlayer\LD4\"
 $ldstopDir = $ldDir+"dnconsole.exe quit --index 0"
$ldstartDir = $ldDir+ "dnconsole.exe launch --index 0"

function terminator([int]$minTime){
	if ($minTime -gt 900){
		$ldstopDir | Invoke-Expression
		write-host "Terminator Shootin at "(Get-Date)" for:"($minTime-100)
		start-sleep ($minTime-100)
		$ldstartDir | Invoke-Expression
		Start-Sleep 100
	}
	else {write-host 'lt 900 secs wait not terminating ,only sleeping';
			start-sleep ($minTime+30)
			}
	return
	
}
echo '' > marchesNTimes.txt


$instx = 'emulator-5554'
$initials = (398,602) , (412,593) , (396,579) , (389,588)
$isPreGen = $false



function availableMarches([int]$nMarches=5){
	
	toMainWorld | out-null
	start-sleep 1
	screenSnap nMarchesUsed$instx.png
	$marchesNTimes = @(0) * 5
	magick convert ../tmp/nMarchesUsed$instx.png -crop 269x30+80+223 ../tmp/nMarchesUsedS1$instx.png
	magick convert ../tmp/nMarchesUsed$instx.png -crop 269x30+80+273 ../tmp/nMarchesUsedS2$instx.png
	magick convert ../tmp/nMarchesUsed$instx.png -crop 269x30+80+325 ../tmp/nMarchesUsedS3$instx.png
	magick convert ../tmp/nMarchesUsed$instx.png -crop 269x30+80+373 ../tmp/nMarchesUsedS4$instx.png
	magick convert ../tmp/nMarchesUsed$instx.png -crop 269x30+80+425 ../tmp/nMarchesUsedS5$instx.png
	$marchesNTimes[0] = py ..\captioner.py ../tmp/nMarchesUsedS1$instx.png 1
	$marchesNTimes[1] = py ..\captioner.py ../tmp/nMarchesUsedS2$instx.png 1
	$marchesNTimes[2] = py ..\captioner.py ../tmp/nMarchesUsedS3$instx.png 1
	$marchesNTimes[3] = py ..\captioner.py ../tmp/nMarchesUsedS4$instx.png 1
	$marchesNTimes[4] = py ..\captioner.py ../tmp/nMarchesUsedS5$instx.png 1
	$matchTerms = 'allyin','xplorin','repari','atherin' , 'eturnin'
	$finArr = @()
	$retArr = @()
	foreach($x in $marchesNTimes){
		
		##need to add a pause while any troops are returning
		$res = matchesOneof $matchTerms $x
		if(($res -eq 'atherin')){$retArr += $x ;}
	}
	$availableMarches = $nMarches- ($retArr.Length)
	if($availableMarches -eq 0){
		$timesArr=@()
		$retArr = $retArr -replace '[^0-9:]'
		foreach($zz in $retArr){
			$timesArr += (	([int]$zz.Split(':')[0]*3600) + ([int]$zz.Split(':')[1]*60) + 60 )
		}
		echo 'Called:'$timesArr >> marchesNTimes.txt
		$min = minimum($timesArr)
		$min = ([int]$min)+400
		terminator ($min-400)
		return
	}
	return $availableMarches
}

function minimum([float[]]$x){
	$curmin = $x[0]
	foreach($y in $x){
		if($y -lt $curmin){$curmin = $y}
	}
echo $curmin
}

function matchesOneof{
    param([string[]]$tochkVals,[string]$arr)
    foreach ($x in $tochkVals){
        $arrFin = @()
        if($arr -match $x){echo $x;break}
		#else {echo 'False'}
		$i++
        }
    }

function farminGenfinder{
		$mainFarmGen = ''
		#.\adb -s $instx shell input touchscreen tap 116 660   #for rallies
		..\adb -s $instx shell input touchscreen tap 116 324
		start-sleep 0.1
		..\adb -s $instx shell input touchscreen tap 360 145
		start-sleep 1
		screenSnap curgen-$instx.png
		$x = 1
		while($x -lt 6){
		#[string] $baib =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaib.png
		#[string] $cleo = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleo.png
		#[string] $cleounsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleoUnsp.png
		#[string] $nath =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNath.png
		#[string] $nathSpec =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNathSpec.png
		#[string] $baibunsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaibUnspec.png
		[string] $jind = py ..\locFinder.py ..\tmp\curgen-$instx.png ..\EvonyImgs\jindeList.png
		[string] $marius = py ..\locFinder.py ..\tmp\curgen-$instx.png ..\EvonyImgs\mariusList.png
		if ($marius-ne $null){$jindX = ([int]$marius.Split(',')[0]) ; $jindY = ([int]$marius.Split(',')[1]) ;echo 'marius'; ..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 850 ; $mainGen='marius' ; break}
		if ($jind-ne $null){$jindX = ([int]$jind.Split(',')[0]) ; $jindY = ([int]$jind.Split(',')[1]) ;echo 'jindeok' ;..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 850 ; $mainGen='jindeok';break}
		#if ($marius-ne $null){$jindX = ([int]$marius.Split(',')[0]) ; $jindY = ([int]$marius.Split(',')[1]) ;echo 'marius'; ..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 850 ; $mainGen='marius' ; break}
		..\adb -s $instx shell input touchscreen swipe 360 700 360 400 450
		start-sleep -ms 2
		screenSnap curgen-$instx.png
		#echo $baib , $cleo , $nath , $nathSpec , $baibunsp
		#read-host "Press ENTER to continue..."
		Write-information "Searching in progress"
		$x = $x + 1
}
		if ($x -eq 6){.\adb -s $instx shell input keyevent 4}
		else {
			timeout 3
			start-sleep 0.25
			#.\adb -s $instx shell input touchscreen tap 116 874		#asst gen selecting coord for monsters
			..\adb -s $instx shell input touchscreen tap 116 570
			start-sleep 0.1
			..\adb -s $instx shell input touchscreen tap 360 145
			start-sleep 1.25
			screenSnap curgen-$instx.png
			#while($sm -lt $quickSwipesAsst ){.\adb -s $instx shell input swipe 510 950 510 450 130;$sm++;start-sleep 0.3}
			while($x -lt 6){
				$sm = 0
				
			[string] $jind = py locFinder.py ..\tmp\curgen-$instx.png ..\EvonyImgs\jindeList.png
			[string] $marius = py locFinder.py ..\tmp\curgen-$instx.png ..\EvonyImgs\mariusList.png
			[string] $lucy = py locFinder.py ..\tmp\curgen-$instx.png ..\EvonyImgs\lucyList.png
			if ($jind-ne $null -and $mainGen -ne 'jindeok'){$jindX = ([int]$jind.Split(',')[0]) ; $jindY = ([int]$jind.Split(',')[1]) ;echo 'selecting Jindeok' ; ..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 850 ; break}
			if ($marius-ne $null -and $mainGen -ne 'marius'){$jindX = ([int]$marius.Split(',')[0]) ; $jindY = ([int]$marius.Split(',')[1]) ;echo 'selecting marius' ; ..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 850 ; break}
			if ($lucy-ne $null){$jindX = ([int]$lucy.Split(',')[0]) ; $jindY = ([int]$lucy.Split(',')[1]) ;echo 'selecting Lucy' ; ..\adb -s $instx shell input touchscreen swipe $jindX $jindY $jindX $jindY 700 ; break}
			..\adb -s $instx shell input touchscreen swipe 360 700 360 400 450
			start-sleep 2
			screenSnap curgen-$instx.png
			#echo $baib , $cleo , $nath , $nathSpec , $baibunsp
			#read-host "Press ENTER to continue..."
			echo "Searching in progress"
			$x = $x + 1
			
		}
	
	}
	if ($x -ge 6){.\adb -s $instx shell input keyevent 4}
	
	
}

function rsonchkFarm{
	start-sleep 2
	screenSnap rsonChkFarm-$instx.png
	$confirmer = py ..\locFinder.py ..\tmp\rsonChkFarm-$instx.png farmingMarchScreenConfirmer.png
	if ($confirmer -eq $null){
		echo 'wrong'
		}
	
}

function fullSlotSleeper([int]$nMarches=5){
	
	toMainWorld
	start-sleep 1
	screenSnap nMarchesUsed$instx.png
	magick convert ../tmp/nMarchesUsed$instx.png -crop 250x280+85+225 ../tmp/nMarchesUsed$instx.png
	$marchesNTimes = py ..\captioner.py ../tmp/nMarchesUsed$instx.png 1
	$matchTerms = 'allying','archin','repari','atherin' , 'eturning'
	$finArr = @()
	$retArr = @()
	foreach($x in $marchesNTimes){
		
		##need to add a pause while any troops are returning
		$res = matchesOneof $matchTerms $x
		if($res -eq 'eturning'){$retArr += $x ;}
		if ($res -ne $null) {$finArr += $x}
	}
	$finArr = $finArr -replace '[^0-9:]'
	if($finArr.Length -lt $nMarches){return}
	if($retArr -ne $null){
		foreach($i in $retArr){
			$retimeInSecs += ([int]$retArr[$i].Split(':')[0])*3600 + ([int]$retArr[$i].Split(':')[1])*60 + ([int]$retArr[$i].Split(':')[2])
		}
		$sleepTime = (minimum($retimeInSecs)) + 5
		start-sleep ($sleepTime)
		return 'returned'
	}
	#echo $finArr
	$marchesNTimes = $finArr
	#echo 'RepairedMarchesNTime:'$marchesNTimes
	$timeInSecs = @()
	if($marchesNTimes.Length -ge $nMarches){
		$i = 0
		while($i -lt $nMarches){
		$timeInSecs += ([int]$marchesNTimes[$i].Split(':')[0])*3600 + ([int]$marchesNTimes[$i].Split(':')[1])*60 + ([int]$marchesNTimes[$i].Split(':')[2])
		$i++
		}
		$sleepTime = ($timeInSecs | Measure -minimum).Minimum
		Write-host -nonewline 'sleeping for '$sleepTime ' in secs coz MarchesNTimesLength='$marchesNTimes.Length
		terminator $sleepTime
	}
	#echo 'TimeinSecsValue:'$timeInSecs
	
}

function screenSnap([string]$one){
		..\adb -s $instx shell screencap -p /sdcard/$one | Out-Null
		..\adb -s $instx pull /sdcard/$one ../tmp/ | Out-Null
		$one | Out-Null
	
}

function presetSelector([int]$npresets){
	$i=0
	$presets = 72,152,242,312,392
	while($i-lt $npresets){
		..\adb -s $instx shell input touchscreen tap $presets[$i] 135
		start-sleep 0.45
		screenSnap preset-$instx.png
		$textt= (py ..\locFinder.py ..\tmp\preset-$instx.png ..\selMainGenButt.png)
		#echo 'textt'$textt
		if($textt -eq $null){$i = 0 ; echo $true ; return}
		$i++
	}
}

function mainHomeSeq{
		..\adb -s $instx shell input keyevent 4
		..\adb -s $instx shell input keyevent 4
		..\adb -s $instx shell input keyevent 4
		..\adb -s $instx shell input keyevent 4
		..\adb -s $instx shell input keyevent 4
		..\adb -s $instx shell input keyevent 4
		start-sleep 0.5
		..\adb -s $instx shell screencap -p /sdcard/coq.png
		..\adb -s $instx pull /sdcard/coq.png ../tmp/coq$instx.png | Out-Null
		magick convert ../tmp/coq$instx.png -crop 117x30+182+742 ..\tmp\coqx$instx.png
		$coq = py ..\captioner.py ..\tmp\coqx$instx.png
		#echo $coq >> logs.txt
		if ($coq.Contains('nce')){..\adb -s $instx shell input keyevent 4}
}

function toMainWorld{
	mainHomeSeq
	screenSnap keepOrWorld$instx.png
	$keepScrOrNot = py ..\locFinder.py ../tmp/keepOrWorld$instx.png ..\RallyShite\castle.png
	echo 'keepscr:'$keepScrOrNot
	if ($keepScrOrNot -eq $null){
	..\adb -s $instx shell input touchscreen tap 667 1207}
}

<#Old Randmover
function randMover([int]$initialsX , [int]$initialsY , [int]$maxDist){ #sleeps 4s at end to give time to load in game assets
	..\adb -s $instx shell input tap 244 1128
	..\adb -s $instx shell input tap 256 700
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	$xxx= Get-Random(4)
	$rand = Get-Random -maximum $maxDist -minimum (-1*$maxDist)
	..\adb -s $instx shell input text ($initialsX + $rand)
	start-sleep 2.5
	..\adb -s $instx shell input tap 519 700
	..\adb -s $instx shell input tap 519 700
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	..\adb -s $instx shell input keyevent 67
	$rand = Get-Random -maximum $maxDist -minimum (-1*$maxDist)
	..\adb -s $instx shell input text ($initialsY + $rand)
	start-sleep 2.5
	..\adb -s $instx shell input tap 350 806
	..\adb -s $instx shell input tap 350 806 #Go Button
	start-sleep 4
	
}#>

#new randMover

function randMover([int]$initialsX , [int]$initialsY , [int]$maxDist){
	
	$xs = (150 , 570)
	$ys = (260 , 1000)
	..\adb -s $instx shell input swipe $initialsX $initialsY $xs[(get-random 2)] $ys[(get-random 2)] 180
	start-sleep 1.3
	
}

<#while ($true) {
	$y = 'ore_tile.jpg','lumb_tile.jpg','food_tile.jpg'
	..\adb -s $instx shell screencap -p /sdcard/screen.png
	..\adb -s $instx pull /sdcard/screen.png ./tmp/screen.png | Out-Null
	copy ./tmp/screen.png F:/farmShite/screen.png												
	#if ($ore_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "ore_tile.jpg" } }
	#if ($food_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "food_tile.jpg" } }
	#if ($lumb_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "lumb_tile.jpg" } }
	#if ($stone_tile[4]  -eq  2){ $y = $y | Where-Object { $_ –ne "stone_tile.jpg" } }#>
	$oresOccupied = 0
	$lumbOccupied = 0
	$stoneOccupied = 0
	$foodOccupied = 0
	$rett = ''
<#
	while($oresOccupied -le $oreMarches){
		if($rett -ne 'returned'){randMover 400 587 80}
		screenSnap('farmScreen.png')
		#[string]$corScr=(py locFinder.py ..\tmp\farmScreen.png .jpg)
		[string]$coord=(py locFinder.py ..\tmp\farmScreen.png ore_tile.jpg) # to get some debug output tryremoving '[int]' , which makes $coord reference to function	
		echo 'coords:'$coord
		$cX = [int]$coord.Split(',')[0]
		$cY = [int]$coord.Split(',')[1] + 10
		#can use CV instead to search for occupy button straight
		if (($cX -eq 0) -or ($cY  -eq  10)){continue}
		..\adb -s $instx shell input tap ($cX) ($cY)
		start-sleep 1.4
		..\adb -s $instx shell screencap -p /sdcard/screen.png
		..\adb -s $instx pull /sdcard/screen.png ./tmp/screen.png | Out-Null
		copy .\tmp\screen.png F:\farmShite\screen.png
		[string]$occ_Loc = py locFinder.py F:\farmShite\screen.png occupy.jpg
		$occ_X = [int]$occ_Loc.Split(',')[0]
		$occ_Y = [int]$occ_Loc.Split(',')[1]
		if(($occ_X  -eq  0) -or ($occ_Y -eq 0)){
			..\adb -s $instx shell input tap 246 1126
			..\adb -s $instx shell input keyevent 4
			continue}
		..\adb -s $instx shell input tap ($occ_X) ($occ_Y)
		#gennSearchToBeDone
		$rsonFarm = rsonchkFarm 
		if($rsonFarm -eq 'wrong'){
			echo 'Chking if all marches are occupied';
			start-sleep 2.5 ; 
			$rett = fullSlotSleeper ;
		if($rett -ne 'returned'){continue}

		}
		$isPreGen = presetSelector 3
		if ($isPreGen -ne $true){
			farminGenfinder
		}
		start-sleep 1
		..\adb -s $instx shell input tap 250 1233
		..\adb -s $instx shell input tap 250 1233
		echo 'MarchingNow'
		start-sleep 2 #debug
		..\adb -s $instx shell input tap 531 1233
		echo 'going bck'
		#..\adb -s $instx shell input keyevent 4	#back instead of march for debug
		#..\adb -s $instx shell input keyevent 4
		$oresOccupied++
		echo 'OresOccupiedIs:'$oresOccupied
		timeout 2
	
	}

#>
$i =0
while ($true){
	#screenSnap mainHomeChk$instx.png
	#toMainWorld
	$avMar = availableMarches
	write-host -nonewline 'Free march slots is : '$avMar
	$coord = (py locFinder.py ..\tmp\farmScreen.png food_tile.jpg)
	while($avMar -ge 0 ){
		if($i % 13 -eq 0){..\adb -s $instx shell input tap 384 1054; $i+=1 ; continue}
		if( $i%17 -eq 0){$avMar = availableMarches;write-host -nonewline 'available marches ->'$avMar;$i+=1}
		if($avMar -ge 390){write-host 'slept for :'($avMar-400) -nonewline; $avMar = availableMarches ; continue}
		randMover 375 640 80
		screenSnap 'farmScreen.png'
		#[string]$corScr=(py locFinder.py ..\tmp\farmScreen.png .jpg)
		[string]$coord=(py locFinder.py ..\tmp\farmScreen.png food_tile.jpg) # to get some debug output tryremoving '[int]' , which makes $coord reference to function	
		echo 'coords:'$coord
		$cX = [int]$coord.Split(',')[0]
		$cY = [int]$coord.Split(',')[1] + 10
		$i+=1
		#can use CV instead to search for occupy button straight
		if (($cX -eq 0) -or ($cY  -eq  10)){continue}
		..\adb -s $instx shell input tap ($cX) ($cY)
		start-sleep 1.4
		..\adb -s $instx shell screencap -p /sdcard/screen.png
		..\adb -s $instx pull /sdcard/screen.png ./tmp/screen.png | Out-Null
		copy .\tmp\screen.png F:\farmShite\screen.png
		[string]$occ_Loc = py locFinder.py F:\farmShite\screen.png occupy.jpg
		$occ_X = [int]$occ_Loc.Split(',')[0]
		$occ_Y = [int]$occ_Loc.Split(',')[1]
		if(($occ_X  -eq  0) -or ($occ_Y -eq 0)){
			..\adb -s $instx shell input tap 246 1126
			..\adb -s $instx shell input keyevent 4
			continue}
		..\adb -s $instx shell input tap ($occ_X) ($occ_Y)
		#gennSearchToBeDone
		$rsonFarm = rsonchkFarm
		if($rsonFarm -eq 'wrong'){mainHomeSeq ; start-sleep 0.2 ; $avMar = availableMarches ;continue}
		<#
			echo 'Chking if all marches are occupied';
			start-sleep 2.5 ; 
			$rett = fullSlotSleeper ;
		if($rett -ne 'returned'){continue}

		}#>
		
		
		
		
		
		#$isPreGen = presetSelector 3
		
		
		start-sleep 1
		..\adb -s $instx shell input tap 250 1233
		..\adb -s $instx shell input tap 250 1233
		echo 'MarchingNow'
		start-sleep 2 #debug
		..\adb -s $instx shell input tap 531 1233
		echo 'going bck'
		#..\adb -s $instx shell input keyevent 4	#back instead of march for debug
		#..\adb -s $instx shell input keyevent 4
		$oresOccupied++
		echo 'OresOccupiedIs:'$oresOccupied
		timeout 2
		$avMar = availableMarches	
	}
}