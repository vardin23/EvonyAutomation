function screenSnap([string]$one){
		.\adb -s $instx shell screencap -p /sdcard/$one
		.\adb -s $instx pull /sdcard/$one ./tmp/$one | Out-Null
	
}
$instx = '127.0.0.1:21503'
$isPreGen = $false
function presetSelector([int]$npresets){
	$i=0
	$presets = 264,339,414,495,565
	while($i-lt $npresets){
		.\adb -s $instx shell input touchscreen tap $presets[$i] 145
		start-sleep 0.35
		screenSnap 'preset-1.png'
		$textt= (py locFinder.py .\tmp\preset-1.png selMainGenButt.png)
		if($textt -eq $null){$i = 0 ; $isPreGen = $true ; break}
		$i++
	}
}

presetSelector 3
<#
# begin build properties
# autogenerated by buildinfo.sh
ro.build.id=PQ3A.190705.003
ro.build.display.id=PQ3A.190705.003 release-keys
ro.build.version.incremental=G9700FXXU1APFO
ro.build.version.sdk=28
ro.build.version.preview_sdk=0
ro.build.version.codename=REL
ro.build.version.all_codenames=REL
ro.build.version.release=9
ro.build.version.security_patch=2019-07-05
ro.build.version.base_os=
ro.build.version.min_supported_target_sdk=17
ro.build.date=Thu Nov 24 08:36:57 CST 2022
ro.build.date.utc=1669250217
ro.build.type=user
ro.build.user=build
ro.build.host=UBNX
ro.build.tags=release-keys
ro.build.flavor=aosp-user
ro.build.system_root_image=true
ro.product.model=AOSP
ro.product.brand=Android
ro.product.name=ld_aosp_x86_64
ro.product.device=gracelte
# ro.product.cpu.abi and ro.product.cpu.abi2 are obsolete,
# use ro.product.cpu.abilist instead.
ro.product.cpu.abi=x86_64
ro.product.cpu.abilist=x86_64,x86,arm64-v8a,armeabi-v7a,armeabi
ro.product.cpu.abilist32=x86,armeabi-v7a,armeabi
ro.product.cpu.abilist64=x86_64,arm64-v8a
ro.product.manufacturer=Google
ro.product.locale=en-US
ro.wifi.channels=
# ro.build.product is obsolete; use ro.product.device
ro.build.product=gracelte
# Do not try to parse description, fingerprint, or thumbprint
ro.build.description=graceltexx-user 9 PQ3A.190705.003 G9700FXXU1APFO release-keys
ro.build.fingerprint=Android/graceltexx/gracelte:9/PQ3A.190705.003/G9700FXXU1APFO:user/release-keys
ro.build.characteristics=tablet
# end build properties
#
# from build/make/target/board/gsi_system.prop
#
# GSI always generate dex pre-opt in system image
ro.cp_system_other_odex=0

# GSI always disables adb authentication
ro.adb.secure=0

# TODO(b/78105955): disable privapp_permissions checking before the bug solved
ro.control_privapp_permissions=disable

#
# ADDITIONAL_BUILD_PROPERTIES
#
vendor.rild.libpath=/vendor/lib64/libmtk-ril.so
keyguard.no_require_sim=true
ro.com.android.dataroaming=true
ro.config.ringtone=Ring_Synth_04.ogg
ro.config.notification_sound=pixiedust.ogg
ro.carrier=unknown
ro.config.alarm_alert=Alarm_Classic.ogg
ro.dalvik.vm.native.bridge=0
dalvik.vm.heapstartsize=8m
dalvik.vm.heapgrowthlimit=192m
dalvik.vm.heapsize=384m
dalvik.vm.heaptargetutilization=0.75
dalvik.vm.heapminfree=512k
dalvik.vm.heapmaxfree=8m
ro.ril.hsxpa=1
ro.ril.gprsclass=10
ro.cdma.home.operator.alpha=Android
ro.cdma.home.operator.numeric=302780
ro.gsm.home.operator.alpha=Android
ro.gsm.home.operator.numeric=302780
gsm.sim.operator.numeric=302780
gsm.sim.operator.alpha=Android
gsm.sim.operator.iso-country=us
ro.dalvik.vm.isa.arm64=x86_64
ro.enable.native.bridge.exec64=1
ro.dalvik.vm.isa.arm=x86
ro.enable.native.bridge.exec=1
persist.sys.nativebridge=1
ro.bionic.ld.warning=1
ro.art.hiddenapi.warning=1
ro.treble.enabled=false
persist.sys.dalvik.vm.lib.2=libart.so
dalvik.vm.isa.x86_64.variant=x86_64
dalvik.vm.isa.x86_64.features=default
dalvik.vm.isa.x86.variant=x86_64
dalvik.vm.isa.x86.features=default
dalvik.vm.lockprof.threshold=500
net.bt.name=Android
dalvik.vm.stack-trace-dir=/data/anr
ro.build.time=1669279649
#>



.\adb -s $instx shell input touchscreen swipe 493 960 493 500
start-sleep 1
screenSnap cavChk-$instx.png
$chk1 = py locFinder.py .\cavChk-$instx.png	.\EvonyImgs\cavIdentifier1.png
$chk2 = py locFinder.py .\cavChk-$instx.png	.\EvonyImgs\cavIdentifier2.png

if ()


function containsOneof{
	param([string[]]$tochkVals,[string[]]$arr)
	foreach ($x in $chkVals){
		$arrFin = @()
		$i =0 
		while($i -lt $arr.Length){
		if($arr[i] in $x){echo 'true';break}	
		$i++
		}
	}
}
while()