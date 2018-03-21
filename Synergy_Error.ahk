;;--- Head --- AHK ---

;; Just wait Synergy error(s) and close it
;; Work with SynergyInstaller-1.3.1.exe

;;--- Softwares options ---

	#SingleInstance Force
	#Persistent
	#NoEnv

	SetWorkingDir, %A_ScriptDir%

	SetEnv, title, Synergy Error
	SetEnv, mode, Close Synergy error(s)
	SetEnv, Author, LostByteSoft
	SetEnv, version, Version 2018-03-21-1158
	SetEnv, icofolder, C:\Program Files\Common Files
	SetEnv, logoicon, Synergy_Error.ico
	SetENv, debug, 0

	;; Specific Icons (or files)
	FileInstall, Synergy_Error.ico, %icofolder%\Synergy_Error.ico, 0

	;; Common ico
	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, ico_loupe.ico, %icofolder%\ico_loupe.ico, 0

;;--- Tray options

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program.
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	;menu, tray, add, Show Gui, start					; Default gui
	;Menu, Tray, Icon, Show Gui, %icofolder%\ico_loupe.ico
	;Menu, Tray, Default, Show Gui
	;Menu, Tray, Click, 1
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (Ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (Ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add, Open A_WorkingDir, A_WorkingDir
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	menu, tray, add,
	Menu, Tray, Tip, %title% %mode%

;;--- Software start here ---

start:

	Menu, Tray, Tip, %mode% In search for S or C. (Sleep 5 sec)
	Sleep, 5000		; for sure the synergy soft has time for loading

If ProcessExist("Synergys.exe")
	goto, server

	If ProcessExist("Synergyc.exe")
		goto, client

	ProcessExist(Name){
		Process,Exist,%Name%
		return Errorlevel
	}

	IfEqual, debug, 1, MsgBox, Wait 30 sec.
	sleep, 30000
	goto, start

server:
	Menu, Tray, Tip, %mode% Running = Server
	SetEnv, running, Server
	IfEqual, debug, 1, MsgBox Synergys.exe exists. If ProcessExist("Synergys.exe")
	WinWait, Synergy 1.3.1 Server
	WinClose, Synergy 1.3.1 Server
	sleep, 5000
	goto, server

client:
	Menu, Tray, Tip, %mode% Running = Client
	SetEnv, running, Client
	IfEqual, debug, 1, MsgBox Synergyc.exe exists. If ProcessExist("Synergyc.exe")
	WinWait, Synergy 1.3.1 Client
	WinClose, Synergy 1.3.1 Client
	sleep, 5000
	goto, client


;;--- Debug ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Goto, sleep2

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Goto, sleep2

;;--- Pause ---

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	goto, sleep

	unpaused:	
	Menu, Tray, Icon, %logoicon%
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Quit ---

ButtonQuit:
	Gui, destroy
	goto, sleep2

ButtonReload:
doReload:
	Gui, destroy
	Reload
	sleep, 500

ButtonExit:
ExitApp:
	Gui, destroy
	ExitApp

GuiClose:
	Gui, destroy
	Goto, sleep2


;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode%, 2, 1
	Return

version:
	TrayTip, %title%, %version%, 2, 2
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull to remove the annoying box that serve nothing.`n`n`tGo to https://github.com/LostByteSoft
	Return

secret:
	MsgBox, 0, SECRET MsgBox, title=%title% - mode=%mode% - version=%version% - author=%author% - A_ScriptDir=%A_ScriptDir% - running=%running%
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	Gui, 4:Color, 000000
	Gui, 4:-MinimizeBox
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

A_WorkingDir:
	IfEqual, debug, 1, msgbox, run, explorer.exe "%A_WorkingDir%"
	run, explorer.exe "%A_WorkingDir%"
	Return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---