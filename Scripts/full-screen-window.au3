; AutoIt script useful for gaming over multiple monitors without using NVidia Surround or AMD Eyefinity
; You will need to download and install AutoIt in order to run this script. See: https://www.autoitscript.com
; Original version from: https://www.reddit.com/r/EliteDangerous/comments/2tbcjl/how_to_run_elite_in_triple_monitor_mode_in/
; Mostly tested with Elite Dangerous on NVidia GeForce driver.
; Configure Elite Dangerous to your custom screen resolution and borderless window mode.
; Adjust some of the constant below to fit your configuration as needed.
; Make sure the script is runnning before you start the game.
;

; Settings
Const $windows[] =["Elite - Dangerous (CLIENT)","MechWarrior Online (64 bit)"]
Const $widths[] =[0,-3] ;-8
Const $heights[] =[0,-25] ;-31

;Const $WinBorderWidth = -8 ;pixels
;Const $WinBorderHeight = -31 ;pixels
;Const $TargetX = -1920 + $WinBorderWidth
;Const $TargetY = 0 + $WinBorderHeight
Const $CheckEvery = 500 ;ms

; Inits
Opt("WinTitleMatchMode", 3)
HotKeySet("#{BACKSPACE}", "Terminate") ;Win+Backspace hotkey to quit the script
$OnTop = False

While 1
	Sleep($CheckEvery)
	Main()
WEnd

Func Main()
   For $i = 0 To UBound($windows) - 1
	  AdjustWindow($windows[$i],-1920 + $widths[$i],0 + $heights[$i])
   Next
EndFunc   ;==>Main

; Adjust position of the given window to fit your screen
Func AdjustWindow($aWnd,$aX,$aY)
   If WinActive($aWnd) Then
   		; Check current window position, reposition if not at target coordinate
		$Current_Window_Position = WinGetPos($aWnd)
		If ($Current_Window_Position[0] <> $aX) Or ($Current_Window_Position[1] <> $aY) Or ($Current_Window_Position[2] <> 5760) Or ($Current_Window_Position[3] <> 1200) Then
			WinMove($aWnd, "", $aX, $aY,5760,1200)
		EndIf

		; Set window to on top if active
		If Not $OnTop Then
			If WinSetOnTop($aWnd, "", 1) Then
				$OnTop = True
			EndIf
		EndIf
	Else
		; Set window to NOT on top if not active
		If $OnTop Then
			If WinSetOnTop($aWnd, "", 0) Then
				$OnTop = False
			EndIf
		EndIf
	EndIf
EndFunc ; AdjustWindows


Func Terminate()
	Exit
EndFunc   ;==>Terminate