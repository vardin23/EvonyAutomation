while($x -lt 10){
		.\adb -s emulator-5564 shell input swipe 300 950 300 450 125
		Start-Job -ScriptBlock {
		start-sleep -ms 90
		.\adb -s emulator-5564 shell input tap 340 40
		}
		.\adb -s emulator-5564 shell input swipe 300 700 300 700 650
		remove-job -state 'Completed'
		.\adb -s emulator-5564 shell screencap -p /sdcard/curgen-5564.png
		.\adb -s emulator-5564 pull /sdcard/curgen-5564.png ./tmp/curgen-5564.png | Out-Null
		
		[string] $baib =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genBaib.png
		[string] $cleo = py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genCleo.png
		[string] $nath =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genNath.png
		[string] $nathSpec =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genNathSpec.png
		[string] $baibunsp = py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genBaibUnspec.png
		
		if ($baib -ne $null){$baibY = ([int]$baib.Split(',')[1] + 24) ;echo 'selecting',$baibY;.\adb -s emulator-5564 shell input touchscreen tap 625 $baibY;break}
		if ($baibunsp -ne $null){$baibY = ([int]$baibunsp.Split(',')[1] + 25) ;echo 'selecting',$baibY;.\adb -s emulator-5564 shell input touchscreen tap 625 $baibY;break;}
		echo $baib , $cleo , $nath , $nathSpec , $baibunsp
		#read-host "Press ENTER to continue..."
		$x = $x + 1
}
		if ($x -eq 10){.\adb -s emulator-5564 shell input keyevent 4}
		else {
			.\adb -s emulator-5564 shell input touchscreen tap 116 860
			start-sleep 1.2
			while($x -lt 12){
				.\adb -s emulator-5564 shell input swipe 300 950 300 450 125
				Start-Job -ScriptBlock {
				start-sleep -ms 90
				.\adb -s emulator-5564 shell input tap 340 40
				}
				.\adb -s emulator-5564 shell input swipe 300 700 300 699 450
				remove-job -state 'Completed'
				.\adb -s emulator-5564 shell screencap -p /sdcard/curgen-5564.png
				.\adb -s emulator-5564 pull /sdcard/curgen-5564.png ./tmp/curgen-5564.png | Out-Null
				
				[string] $baib =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genBaib.png
				[string] $cleo = py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genCleo.png
				[string] $nath =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genNath.png
				[string] $nathSpec =py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genNathSpec.png
				[string] $baibunsp = py locFinder.py .\tmp\curgen-5564.png .\EvonyImgs\genBaibUnspec.png
				
				if ($nath -ne $null){$nathY = ([int]$nath.Split(',')[1] + 24) ;echo 'selecting',$nathY;.\adb -s emulator-5564 shell input touchscreen tap 625 $nathY;break}
				if ($nathSpec -ne $null){$nathY = ([int]$nathSpec.Split(',')[1] + 24) ;echo 'selecting',$nathY;.\adb -s emulator-5564 shell input touchscreen tap 625 $nathY;break}	
			
		}
	
	}