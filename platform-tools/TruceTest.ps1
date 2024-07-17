$instx = 'emulator-5574'
function screenSnap([string]$one){
		.\adb -s $instx shell screencap -p /sdcard/$one
		.\adb -s $instx pull /sdcard/$one ./tmp/$one | Out-Null
	
}
function mainHomeSeq{
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		.\adb -s $instx shell input keyevent 4
		start-sleep 1.5
		.\adb -s $instx shell screencap -p /sdcard/coq.png
		.\adb -s $instx pull /sdcard/coq.png ./tmp/coq.png | Out-Null
		magick convert ./tmp/coq.png -crop 117x30+182+742 .\tmp\coqx.png
		$coq = py captioner.py .\tmp\coqx.png
		echo $coq >> logs.txt
		if ($coq.Contains('nce')){.\adb -s $instx shell input keyevent 4}
}

function TruceWork{
	mainHomeSeq
	screenSnap('keepOrWorld.png')
	$keepScrOrNot = py locFinder.py ./tmp/keepOrWorld.png .\RallyShite\castle.png
	
	echo 'keepscr:'$keepScrOrNot
	timeout 1
	.\adb -s $instx shell input touchscreen tap 667 1207
	while ($keepScrOrNot -eq $null){
	.\adb -s $instx shell input touchscreen tap 667 1207
	start-sleep 2
	screenSnap('keepOrWorld.png')
	$keepScrOrNot = py locFinder.py ./tmp/keepOrWorld.png .\RallyShite\castle.png
	}
		timeout 2
		##press march slot hide button here(missing)
		screenSnap('latSnap.png')
		#$title = py locFinder.py .\tmp\latSnap.png .\RallyShite\TruceAgreement.png
		.\adb -s $instx shell input touchscreen tap 360 640
		start-sleep 1.5
		.\adb -s $instx shell input touchscreen tap 395 482
		start-sleep 0.5
		screenSnap('latSnap.png')
		$title = py locFinder.py .\tmp\latSnap.png .\RallyShite\TruceAgreement.png
		[string]$tapX = $title.Split(',')[0]
		[string]$tapY = $title.Split(',')[1]
		write-host 'tapx:',$tapX,'tapY:',$tapY -separator ' ' 
		.\adb -s $instx shell input touchscreen tap $tapX $tapY
		start-sleep 0.3
		screenSnap('useTruceScreen.png')
		$loc8H = py locFinder.py .\tmp\useTruceScreen.png .\RallyShite\truce8Hr.png
		$loc24H = py locFinder.py .\tmp\useTruceScreen.png .\RallyShite\truce24Hr.png
		$yloc8 = [int]$loc8H.Split(',')[1] + 55
		$yloc24 = [int]$loc24H.Split(',')[1] + 55
		.\adb -s $instx shell input touchscreen tap 600 $yloc8
		start-sleep 0.5
		screenSnap('useTruceScreen.png')
		$isGem = py locFinder.py useTruceScreen.png truceGemUsage.png
		$isBuyButt = py locFinder.py useTruceScreen.png buyButtTruce.png
		if( ($isGem -eq $null ) -and ($isBuyButt -eq $null) ){
			
			
			.\adb -s $instx shell input touchscreen tap 480 760##confirm use for 8 hr
		
		
		}
		else { 
		.\adb -s $instx shell input keyevent 4
		start-sleep 0.2
		.\adb -s $instx shell input touchscreen tap 600 $yloc24
		start-sleep 0.15
		screenSnap('useTruceScreen.png')
		$isGem = py locFinder.py useTruceScreen.png truceGemUsage.png
		$isBuyButt = py locFinder.py useTruceScreen.png buyButtTruce.png
		if( ($isGem -eq $null ) -and ($isBuyButt -eq $null) ){
			
			.\adb -s $instx shell input touchscreen tap 480 760##confirm use for 8 hr
			
		}
		echo $yloc24
		start-sleep 1
		.\adb -s $instx shell input touchscreen tap ##can't be static
	
	
}

TruceWork