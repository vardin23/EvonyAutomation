$x = .\adb devices
$i=2
while ($i -lt $x.length){
	$z = $x[$i-1].Split('device')[0].trim()
	write-host '[string]$instx = ',$z -separator '' > RallyJoiners-$z.ps1
	cat RallyJoiner.ps1 >> RallyJoiners-$z.ps1
	$i++
}