$quickSwipesM = 6
$quickSwipesAsst = 14
$instx = 'emulator-5558'


function genfinder{
	
	.\adb -s $instx shell screencap -p /sdcard/gen-$instx.png
	.\adb -s $instx pull /sdcard/gen-$instx.png ./tmp/gen-$instx.png | Out-Null
	magick convert ./tmp/gen-$instx.png -crop 97x53+231+635 .\tmp\gen-$instx.png
	$textt= (py captioner.py .\tmp\gen-$instx.png )
	if (($textt.Contains('elec'))){
		.\adb -s $instx shell input touchscreen tap 116 660
		start-sleep 1.2
		$x = 1
		while($x -lt 10){
		
		.\adb -s $instx shell screencap -p /sdcard/gen-$instx.png
		.\adb -s $instx pull /sdcard/gen-$instx.png ./tmp/curgen-$instx.png | Out-Null
		
		[string] $baib =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaib.png
		[string] $cleo = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleo.png
		[string] $cleounsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genCleoUnsp.png
		[string] $nath =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNath.png
		[string] $nathSpec =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNathSpec.png
		[string] $baibunsp = py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genBaibUnspec.png
		
		if ($baib-ne $null){$baibY = ([int]$baib.Split(',')[1] + 24) ;echo 'selecting Baib',$baibY;.\adb -s $instx shell input touchscreen tap 625 $baibY ; break}
		if ($baibunsp -ne $null){$baibY = ([int]$baibunsp.Split(',')[1] + 49) ;echo 'selecting BaibUnsp',$baibY;.\adb -s $instx shell input touchscreen tap 560 $baibY; break}
		if ($cleounsp -ne $null){$baibY = ([int]$cleounsp.Split(',')[1] + 15) ;echo 'selecting CleoUnsp',$baibY;.\adb -s $instx shell input touchscreen tap 625 $baibY ; break}
		if ($cleo -ne $null){$baibY = ([int]$cleo.Split(',')[1] + 15) ;echo 'selecting cleo',$baibY;.\adb -s $instx shell input touchscreen tap 625 $baibY ; break}
		
		Start-Job -ScriptBlock{
			.\adb -s $using:instx shell input swipe 500 1000 500 400 500
				}
		start-sleep -ms 650
		get-job | stop-job
		start-sleep 1
		.\adb -s $instx shell screencap -p /sdcard/curgen-$instx.png
		.\adb -s $instx pull /sdcard/curgen-$instx.png ./tmp/curgen-$instx.png | Out-Null
		
		
		
		
		echo $baib , $cleo , $nath , $nathSpec , $baibunsp
		#read-host "Press ENTER to continue..."
		$x = $x + 1
}
		if ($x -eq 10){.\adb -s $instx shell input keyevent 4}
		else {
			start-sleep 1.25
			.\adb -s $instx shell input touchscreen tap 116 874
			start-sleep 0.7
			while($sm -lt $quickSwipesAsst ){.\adb -s $instx shell input swipe 510 950 510 450 130;$sm++;start-sleep 0.3}
			while($x -lt 10){
				$sm = 0
				
				[string] $nath =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNath.png
				[string] $nathSpec =py locFinder.py .\tmp\curgen-$instx.png .\EvonyImgs\genNathSpec.png
				
				if ($nath -ne $null){$nathY = ([int]$nath.Split(',')[1] + 64) ;echo 'selecting',$nathY;.\adb -s $instx shell input touchscreen tap 625 $nathY ; break}
				if ($nathSpec -ne $null){$nathY = ([int]$nathSpec.Split(',')[1] + 64) ;echo 'selecting',$nathY;.\adb -s $instx shell input touchscreen tap 625 $nathY ; break}
				
				
		Start-Job -ScriptBlock{
			.\adb -s $using:instx shell input swipe 500 1000 500 400 500
				}
		start-sleep -ms 650
		get-job | stop-job
		start-sleep 1
				.\adb -s $instx shell screencap -p /sdcard/curgen-$instx.png
				.\adb -s $instx pull /sdcard/curgen-$instx.png ./tmp/curgen-$instx.png | Out-Null
				$x++
					
			
		}
	
	}
	if ($x -eq 10){.\adb -s $instx shell input keyevent 4}
}
	
}

genfinder