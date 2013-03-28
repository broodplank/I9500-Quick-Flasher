#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=D:/Downloads/1332576732_android.ico
#AutoIt3Wrapper_Outfile=sgsflasher_x86.exe
#AutoIt3Wrapper_Outfile_x64=sgsflasher_x64.exe
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=�2013 broodplank.net
#AutoIt3Wrapper_Res_Fileversion=0.1.4.0
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

;Options
Opt("GUICloseonEsc", 0)

;Includes
#include <WindowsConstants.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <Process.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <Constants.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <String.au3>
#include <ExtProp.au3>
#include <ProgressConstants.au3>



;Static paths!
FileInstall("E:/android/i9500/img/bar.jpg", @TempDir & "/bar.jpg", 1)
FileInstall("E:/android/i9500/img/barv.jpg", @TempDir & "/barv.jpg", 1)


;Create GUI
$GUI = GUICreate("I9500 Quick Flasher", 560, 535)
GUISetFont(8, 8, 0, "Verdana", $GUI)

GUICtrlCreateLabel("Flashing Log:", 305, 5)
$log = GUICtrlCreateEdit("-------------------------------------------" & @CRLF & "I9500 Quick Flasher v1.0 initiated..", 305, 22, 251, 475, BitOR($WS_VSCROLL, $ES_AUTOVSCROLL, $ES_MULTILINE, $ES_READONLY))
$progress = GUICtrlCreateProgress(305, 500, 251, 15, $PBS_SMOOTH)
_AddLog("Coded by broodplank1337 @ XDA")

GUICtrlCreatePic(@TempDir & "/barv.jpg", 300, 0, 1, 519)

GUICtrlCreateLabel("Partition: boot.img (Kernel)" & @CRLF & "Location: /dev/block/mmcblk0p9", 5, 5)
$wipe_bootimg = GUICtrlCreateCheckbox("Wipe before flashing", 5, 55)
GUICtrlSetState($wipe_bootimg, $GUI_DISABLE)
$flash_bootimg = GUICtrlCreateCheckbox("Flash a new Kernel", 5, 35)
$path_bootimg = GUICtrlCreateInput("Locate " & Chr(34) & "boot.img" & Chr(34), 5, 80, 200, 20)
GUICtrlSetState($path_bootimg, $GUI_DISABLE)
$browse_bootimg = GUICtrlCreateButton("Browse...", 210, 79, 80, 22)
GUICtrlSetState($browse_bootimg, $GUI_DISABLE)
GUICtrlCreatePic(@TempDir & "/bar.jpg", 0, 105, 300, 1)


GUICtrlCreateLabel("Partition: recovery.img (Recovery)" & @CRLF & "Location: /dev/block/mmcblk0p10", 5, 115)
$wipe_recovery = GUICtrlCreateCheckbox("Wipe before flashing", 5, 165)
GUICtrlSetState($wipe_recovery, $GUI_DISABLE)
$flash_recovery = GUICtrlCreateCheckbox("Flash a new Recovery", 5, 145)
$path_recovery = GUICtrlCreateInput("Locate " & Chr(34) & "recovery.img" & Chr(34), 5, 190, 200, 20)
GUICtrlSetState($path_recovery, $GUI_DISABLE)
$browse_recovery = GUICtrlCreateButton("Browse...", 210, 189, 80, 22)
GUICtrlSetState($browse_recovery, $GUI_DISABLE)
GUICtrlCreatePic(@TempDir & "/bar.jpg", 0, 215, 300, 1)

GUICtrlCreateLabel("Partition: system.img.ext4 (ROM Base)" & @CRLF & "Location: /dev/block/mmcblk0p20", 5, 225)
$wipe_system = GUICtrlCreateCheckbox("Wipe before flashing", 5, 275)
GUICtrlSetState($wipe_system, $GUI_DISABLE)
$flash_system = GUICtrlCreateCheckbox("Flash a new ROM Base", 5, 255)
$path_system = GUICtrlCreateInput("Locate " & Chr(34) & "system.img.ext4" & Chr(34), 5, 300, 200, 20)
GUICtrlSetState($path_system, $GUI_DISABLE)
$browse_system = GUICtrlCreateButton("Browse...", 210, 299, 80, 22)
GUICtrlSetState($browse_system, $GUI_DISABLE)
GUICtrlCreatePic(@TempDir & "/bar.jpg", 0, 325, 300, 1)


GUICtrlCreateLabel("Flash Custom Partition (advanced)" & @CRLF & "Location: /dev/block/mmcblk0pxx", 5, 335)
$partition = GUICtrlCreateCombo("coming soon...", 5, 390, 175, 18, $CBS_DROPDOWNLIST)
GUICtrlSetState($partition, $GUI_DISABLE)
GUICtrlSetData($partition, "mmcblk0p14 (param)|mmcblk0p16 (cache)|mmcblk0p17 (data)|mmcblk0p18 (preload)")
$wipe_custom = GUICtrlCreateCheckbox("Wipe at start", 190, 365)
GUICtrlSetState($wipe_custom, $GUI_DISABLE)
$flash_custom = GUICtrlCreateCheckbox("Flash an other partition", 5, 365)
GUICtrlSetState($flash_custom, $GUI_DISABLE)
$path_custom = GUICtrlCreateInput("Locate " & Chr(34) & "xxxxxxx.img.ext4" & Chr(34), 5, 415, 200, 20)
GUICtrlSetState($path_custom, $GUI_DISABLE)
$browse_custom = GUICtrlCreateButton("Browse...", 210, 414, 80, 22)
GUICtrlSetState($browse_custom, $GUI_DISABLE)
GUICtrlCreatePic(@TempDir & "/bar.jpg", 0, 440, 300, 1)


GUICtrlCreateLabel("Click on the " & Chr(34) & "Start Now" & Chr(34) & " button to start the process.", 5, 447)
$start = GUICtrlCreateButton("Start Now", 5, 462, 290, 25)
$help = GUICtrlCreateButton("Instructions", 5, 492, 142, 20)
$about = GUICtrlCreateButton("About this app", 153, 492, 142, 20)

GUICtrlCreatePic(@TempDir & "/bar.jpg", 0, 518, 300, 1)
GUICtrlCreatePic(@TempDir & "/bar.jpg", 300, 518, 300, 1)


$copyright = GUICtrlCreateLabel("�2013 broodplank.net - Use with caution! I am not responsible for damage done to your device.", 5, 520)
GUICtrlSetStyle($copyright, $WS_DISABLED)

GUICtrlSetState($start, $GUI_DISABLE)

GUISetState()
If FileExists(@ScriptDir & "/state") Then FileDelete(@ScriptDir & "/state")
If FileExists(@ScriptDir & "/root") Then FileDelete(@ScriptDir & "/root")
If FileExists(@ScriptDir & "/su") Then FileDelete(@ScriptDir & "/su")
_AddLog("-------------------------------------------")
_AddLog(@CRLF & "Running checks, please wait...")
GUICtrlSetData($progress, 10)
_AddLog(@CRLF & "<<< I9500 USB Connection >>>")
RunWait(@ScriptDir & "/status.bat", "", @SW_HIDE)
If FileReadLine(@ScriptDir & "/state", 3) = "unknown" Or FileReadLine(@ScriptDir & "/state", 3) = "offline" Or FileReadLine(@ScriptDir & "/state", 3) = "bootloader" Then
	_AddLog("[ ] I9500 USB Connection")
	_AddLog(@CRLF & "Your I9500 is not connected or unreachable! Please read the instructions for reference.")
	GUICtrlSetData($progress, 0)
Else
	_AddLog("[X] I9500 USB Connection")
	GUICtrlSetData($progress, 30)
	_AddLog(@CRLF & "<<< Android Debug Bridge >>>")
	If FileExists(@ScriptDir & "/adb.exe") = 0 Or FileExists(@ScriptDir & "/AdbWinApi.dll") = 0 Or FileExists(@ScriptDir & "/AdbWinUsbApi.dll") = 0 Then
		_AddLog("[ ] ADB Found " & @CRLF & "Status: Fix installation to proceed.")
		GUICtrlSetData($progress, 0)
	Else
		If FileExists(@ScriptDir & "/state") Then FileDelete(@ScriptDir & "/state")
		If FileExists(@ScriptDir & "/root") Then FileDelete(@ScriptDir & "/root")
		If FileExists(@ScriptDir & "/su") Then FileDelete(@ScriptDir & "/su")
		_AddLog("[X] ADB Found")
		GUICtrlSetData($progress, 40)
		ProcessClose("adb.exe")
		$adbroot = RunWait(@ScriptDir & "/adb.exe root", "", @SW_HIDE)
		If @error Then
			GUICtrlSetData($progress, 0)
			MsgBox(0, "I9500 Quick Flasher", "Unknown ADB error, Exiting!")
			Exit
		EndIf
		_AddLog("[X] ADB started in root mode")
		GUICtrlSetData($progress, 50)
		_AddLog(@CRLF & "<<< Root Access >>>")
		RunWait(@ScriptDir & "/rootexist.bat", "", @SW_HIDE)
		$lines = _FileCountLines(@ScriptDir & "/su")
		If FileReadLine(@ScriptDir & "/su", $lines) = 1 Then
			_AddLog("[ ] Root Found")
			_AddLog("No root access has been found, stopping process.")
			GUICtrlSetData($progress, 0)
		Else
			_AddLog("[X] Root Found")
			GUICtrlSetData($progress, 70)
			RunWait(@ScriptDir & "/root.bat", "", @SW_HIDE)
			$lines = _FileCountLines(@ScriptDir & "/root")
			$READ = FileReadLine(@ScriptDir & "/root", $lines)
			If $READ = "mount: Operation not permitted" Then
				_AddLog("[X] Use extra mounting support")
				GUICtrlSetData($progress, 80)
				Run(@ScriptDir & "/adb.exe -d shell su -c" & Chr(34) & "mount -o remount rw /system" & Chr(34), "", @SW_HIDE)
				Run(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "mount -o remount rw /sdcard" & Chr(34), "", @SW_HIDE)
				_AddLog(@CRLF & "<<< Application State >>>")
				_AddLog("[X] Ready to flash!")
				GUICtrlSetData($progress, 100)
				_AddLog(@CRLF & "Note: this log will be cleared when flashing will be started.")
				Sleep(250)
				GUICtrlSetData($progress, 0)
				GUICtrlSetState($start, $GUI_ENABLE)
			Else
				_AddLog(@CRLF & "[ ] Use extra mounting support")
				Run(@ScriptDir & "/adb.exe -d shell su -c" & Chr(34) & "mount -o remount rw /system" & Chr(34), "", @SW_HIDE)
				Run(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "mount -o remount rw /sdcard" & Chr(34), "", @SW_HIDE)
				GUICtrlSetData($progress, 80)
				_AddLog(@CRLF & "<<< Application State >>>")
				_AddLog("[X] Ready to flash!")
				GUICtrlSetData($progress, 100)
				_AddLog(@CRLF & "Note: this log will be cleared when flashing will be started.")
				Sleep(250)
				GUICtrlSetData($progress, 0)
				GUICtrlSetState($start, $GUI_ENABLE)
			EndIf
		EndIf
	EndIf
	If FileExists(@ScriptDir & "/state") Then FileDelete(@ScriptDir & "/state")
	If FileExists(@ScriptDir & "/root") Then FileDelete(@ScriptDir & "/root")
	If FileExists(@ScriptDir & "/su") Then FileDelete(@ScriptDir & "/su")
EndIf




;While loop
While 1
	$msg = GUIGetMsg()


	Select


		Case $msg = $gui_event_close
			ProcessClose("adb.exe")
			Exit

		Case $msg = $flash_bootimg And BitAND(GUICtrlRead($flash_bootimg), $GUI_Checked) = $GUI_Checked
			GUICtrlSetState($wipe_bootimg, $GUI_ENABLE)
			GUICtrlSetState($path_bootimg, $GUI_ENABLE)
			GUICtrlSetState($browse_bootimg, $GUI_ENABLE)

		Case $msg = $flash_bootimg And BitAND(GUICtrlRead($flash_bootimg), $GUI_UnChecked) = $GUI_UnChecked
			GUICtrlSetState($wipe_bootimg, $GUI_UnChecked)
			GUICtrlSetState($wipe_bootimg, $GUI_DISABLE)
			GUICtrlSetState($path_bootimg, $GUI_DISABLE)
			GUICtrlSetState($browse_bootimg, $GUI_DISABLE)


		Case $msg = $flash_recovery And BitAND(GUICtrlRead($flash_recovery), $GUI_Checked) = $GUI_Checked
			GUICtrlSetState($wipe_recovery, $GUI_ENABLE)
			GUICtrlSetState($path_recovery, $GUI_ENABLE)
			GUICtrlSetState($browse_recovery, $GUI_ENABLE)

		Case $msg = $flash_recovery And BitAND(GUICtrlRead($flash_recovery), $GUI_UnChecked) = $GUI_UnChecked
			GUICtrlSetState($wipe_recovery, $GUI_UnChecked)
			GUICtrlSetState($wipe_recovery, $GUI_DISABLE)
			GUICtrlSetState($path_recovery, $GUI_DISABLE)
			GUICtrlSetState($browse_recovery, $GUI_DISABLE)

		Case $msg = $flash_system And BitAND(GUICtrlRead($flash_system), $GUI_Checked) = $GUI_Checked
			GUICtrlSetState($wipe_system, $GUI_ENABLE)
			GUICtrlSetState($path_system, $GUI_ENABLE)
			GUICtrlSetState($browse_system, $GUI_ENABLE)

		Case $msg = $flash_system And BitAND(GUICtrlRead($flash_system), $GUI_UnChecked) = $GUI_UnChecked
			GUICtrlSetState($wipe_system, $GUI_UnChecked)
			GUICtrlSetState($wipe_system, $GUI_DISABLE)
			GUICtrlSetState($path_system, $GUI_DISABLE)
			GUICtrlSetState($browse_system, $GUI_DISABLE)


		Case $msg = $flash_custom And BitAND(GUICtrlRead($flash_custom), $GUI_Checked) = $GUI_Checked
			GUICtrlSetState($wipe_custom, $GUI_ENABLE)
			GUICtrlSetState($path_custom, $GUI_ENABLE)
			GUICtrlSetState($browse_custom, $GUI_ENABLE)
			GUICtrlSetState($partition, $GUI_ENABLE)


		Case $msg = $flash_custom And BitAND(GUICtrlRead($flash_custom), $GUI_UnChecked) = $GUI_UnChecked
			GUICtrlSetState($wipe_custom, $GUI_UnChecked)
			GUICtrlSetState($wipe_custom, $GUI_DISABLE)
			GUICtrlSetState($path_custom, $GUI_DISABLE)
			GUICtrlSetState($browse_custom, $GUI_DISABLE)
			GUICtrlSetState($partition, $GUI_DISABLE)

		Case $msg = $help
			MsgBox(0, "I9500 Quick Flasher", "Instructions:" & @CRLF & @CRLF & "1. Connect your I9500 in debugging mode to the PC using the USB cable" & @CRLF & "( Settings > Applications > Development > USB Debugging )" & @CRLF & @CRLF & "2. Collect the files that you want to flash to your phone" & @CRLF & "(for example you want to install a kernel and recovery)" & @CRLF & @CRLF & "3. Check the partition boxes that you want to flash." & @CRLF & @CRLF & "4. Load the images (boot.img and recovery.img in this case) by clicking the  " & Chr(34) & "Browse..." & Chr(34) & " button" & @CRLF & @CRLF & "5. As additional option you can choose to wipe the partition before flashing it." & @CRLF & @CRLF & "6. Click " & Chr(34) & "Start Now" & Chr(34) & " to start the flashing process" & @CRLF & @CRLF & "7. Sit back and wait until your I9500 reboots, now you're done :)" & @CRLF & @CRLF & "Please Note: This tool is not some tool to screw around with!" & @CRLF & "Flashing a kernel from another phone would lead to an unrepairable hard brick!" & @CRLF & "So please take care at all times when using I9500 Quick Flasher")


		Case $msg = $about
			MsgBox(0, "I9500 Quick Flasher", "About:" & @CRLF & @CRLF & "I9500 Quick Flasher v1.0 " & @CRLF & "Coded by broodplank(1337)" & @CRLF & @CRLF & "Official Site: wwww.broodplank.net/quickflasher.php" & @CRLF & "XDA Topic: forum.xda-developers.com/showthread.php?t=1574149" & @CRLF & "Donate Page: www.broodplank.net/donate.html")

		Case $msg = $browse_bootimg
			$getpath_bootimg = FileOpenDialog("I9500 Quick Flasher", @WorkingDir, "Image Files (*.img)", 1, "boot.img")
			GUICtrlSetData($path_bootimg, $getpath_bootimg)

		Case $msg = $browse_recovery
			$getpath_recovery = FileOpenDialog("I9500 Quick Flasher", @WorkingDir, "Image Files (*.img)", 1, "recovery.img")
			GUICtrlSetData($path_recovery, $getpath_recovery)

		Case $msg = $browse_system
			$getpath_system = FileOpenDialog("I9500 Quick Flasher", @WorkingDir, "Image/Ext4 Files (*.img.ext4)", 1, "system.img.ext4")
			GUICtrlSetData($path_system, $getpath_system)

		Case $msg = $browse_custom
			$getpath_custom = FileOpenDialog("I9500 Quick Flasher", @WorkingDir, "Image/Ext4 Files (*.img.ext4)", 1, "*.img.ext4")
			GUICtrlSetData($path_custom, $getpath_custom)



		Case $msg = $start

			GUICtrlSetData($log, "-------------------------------------------" & @CRLF & "I9500 Quick Flasher v1.0")
			_AddLog("Coded by broodplank1337 @ XDA")
			_AddLog("-------------------------------------------")
			If GUICtrlRead($flash_bootimg) & GUICtrlRead($flash_recovery) & GUICtrlRead($flash_custom) & GUICtrlRead($flash_system) = "4444" Then
				_AddLog(@CRLF & "No items have been selected, please make a selection and press the " & Chr(34) & "Start Now" & Chr(34) & " button to continue.")
			Else

				_AddLog(@CRLF & ">>> Flashing started <<<")

				If BitAND(GUICtrlRead($flash_bootimg), $GUI_Checked) = $GUI_Checked Then
					_Flashbootimg()
				EndIf

				If BitAND(GUICtrlRead($flash_recovery), $GUI_Checked) = $GUI_Checked Then
					_Flashrecovery()
				EndIf

				If BitAND(GUICtrlRead($flash_system), $GUI_Checked) = $GUI_Checked Then
					_Flashsystem()
				EndIf

				If BitAND(GUICtrlRead($flash_custom), $GUI_Checked) = $GUI_Checked Then
					_Flashcustom()
				EndIf


				_AddLog(@CRLF & "All operations completed!")
				_AddLog("Rebooting Device...")
				Run(@ScriptDir & "/adb.exe " & Chr(34) & "reboot" & Chr(34), "", @SW_HIDE)
				_AddLog(@CRLF & "All done...")
				GUICtrlSetData($progress, 100)

			EndIf


	EndSelect

WEnd

Func _Flashbootimg()
	GUICtrlSetData($progress, 10)
	_AddLog(@CRLF & "[X] Copy boot.img to sdcard")
	GUICtrlSetData($progress, 20)
	RunWait(@ScriptDir & "/adb.exe push " & Chr(34) & $getpath_bootimg & Chr(34) & " " & Chr(34) & "/sdcard/boot.img" & Chr(34), "", @SW_HIDE)
	GUICtrlSetData($progress, 30)
	If BitAND(GUICtrlRead($wipe_bootimg), $GUI_Checked) = $GUI_Checked Then
		GUICtrlSetData($progress, 40)
		RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/dev/zero of=/dev/block/mmcblk0p9" & Chr(34), "", @SW_HIDE)
		_AddLog("[X] Wipe /mmcblk0p8")
		GUICtrlSetData($progress, 50)
	EndIf
	GUICtrlSetData($progress, 70)
	RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/sdcard/boot.img of=/dev/block/mmcblk0p9" & Chr(34), "", @SW_HIDE)
	_AddLog("[X] Datadump boot.img to partition")
	GUICtrlSetData($progress, 90)
	_AddLog(@CRLF & "Flashing Kernel done..")
EndFunc   ;==>_Flashbootimg

Func _Flashrecovery()
	GUICtrlSetData($progress, 10)
	_AddLog(@CRLF & "[X] Copy recovery.img to sdcard")
	GUICtrlSetData($progress, 20)
	RunWait(@ScriptDir & "/adb.exe push " & Chr(34) & $getpath_recovery & Chr(34) & " " & Chr(34) & "/sdcard/recovery.img" & Chr(34), "", @SW_HIDE)
	GUICtrlSetData($progress, 30)
	If BitAND(GUICtrlRead($wipe_recovery), $GUI_Checked) = $GUI_Checked Then
		GUICtrlSetData($progress, 40)
		RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/dev/zero of=/dev/block/mmcblk0p10" & Chr(34), "", @SW_HIDE)
		_AddLog("[X] Wipe /mmcblk0p13")
		GUICtrlSetData($progress, 50)
	EndIf
	GUICtrlSetData($progress, 70)
	RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/sdcard/recovery.img of=/dev/block/mmcblk0p10" & Chr(34), "", @SW_HIDE)
	_AddLog("[X] Datadump recovery.img to partition")
	_AddLog(@CRLF & "Flashing Recovery done..")
	GUICtrlSetData($progress, 90)
EndFunc   ;==>_Flashrecovery


Func _Flashsystem()
	GUICtrlSetData($progress, 10)
	_AddLog(@CRLF & "[ ] Copy system.img.ext4 to sdcard")
	RunWait(@ScriptDir & "/adb.exe push " & Chr(34) & $getpath_system & Chr(34) & " " & Chr(34) & "/sdcard/system.img.ext4" & Chr(34), "", @SW_HIDE)
	_AddLog(@CRLF & "[X] Copy system.img.ext4 to sdcard")
	GUICtrlSetData($progress, 30)
	If BitAND(GUICtrlRead($wipe_system), $GUI_Checked) = $GUI_Checked Then
		GUICtrlSetData($progress, 50)
		RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/dev/zero of=/dev/block/mmcblk0p20" & Chr(34), "", @SW_HIDE)
		_AddLog("[X] Wipe /mmcblk0p15")
		GUICtrlSetData($progress, 60)
	EndIf
	GUICtrlSetData($progress, 70)
	_AddLog("[X] Freeze Device")
	RunWait(@ScriptDir & "/adb.exe -d shell su -c stop", "", @SW_HIDE)
	RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/sdcard/system.img.ext4 of=/dev/block/mmcblk0p20" & Chr(34), "", @SW_HIDE)
	_AddLog("[X] Datadump recovery.img.ext4 to partition")
	GUICtrlSetData($progress, 80)
	_AddLog(@CRLF & "Flashing System done..")
	GUICtrlSetData($progress, 90)
EndFunc   ;==>_Flashsystem

Func _Flashcustom()

	$custompartition = StringLeft(GUICtrlRead($partition), 10)
	_AddLog(@CRLF & "Chosen custom partition: " & $custompartition)
	_AddLog(@CRLF & "Chosen partition file: " & @CRLF & $getpath_custom)
	GUICtrlSetData($progress, 10)
	$customfile = _GetExtProperty($getpath_custom, 0)
	_AddLog(@CRLF & "[ ] Copy " & $customfile & " to sdcard")
	GUICtrlSetData($progress, 20)
	RunWait(@ScriptDir & "/adb.exe push " & Chr(34) & $getpath_custom & Chr(34) & " " & Chr(34) & "/sdcard/" & $customfile & Chr(34), "", @SW_HIDE)
	_AddLog(@CRLF & "[X] Copy " & $customfile & " to sdcard")
	GUICtrlSetData($progress, 40)
	If BitAND(GUICtrlRead($wipe_custom), $GUI_Checked) = $GUI_Checked Then
		GUICtrlSetData($progress, 50)
		RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/dev/zero of=/dev/block/" & $custompartition & Chr(34), "", @SW_HIDE)
		_AddLog("[X] Wipe /" & $custompartition)
		GUICtrlSetData($progress, 60)
	EndIf
	_AddLog("dd " & $customfile & " to " & $custompartition & "... This may take a while, please be patient.")
	GUICtrlSetData($progress, 70)
	_AddLog("Freezing device...")
	RunWait(@ScriptDir & "/adb.exe -d shell su -c stop", "", @SW_HIDE)
	RunWait(@ScriptDir & "/adb.exe -d shell su -c " & Chr(34) & "dd if=/sdcard/" & $customfile & " of=/dev/block/" & $custompartition & Chr(34), "", @SW_HIDE)
	_AddLog("[X] Datadump " & $customfile & " to partition")
	GUICtrlSetData($progress, 80)
	_AddLog(@CRLF & "Flashing custom partition done..")
	GUICtrlSetData($progress, 90)
EndFunc   ;==>_Flashcustom

Func _AddLog($string)
	$CurrentLog = GUICtrlRead($log)
	$NewLog = $CurrentLog & @CRLF & $string
	GUICtrlSetData($log, $NewLog)
EndFunc   ;==>_AddLog


