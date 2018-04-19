@taskkill /f /im "Synergy_Error.exe"
@echo Version 2018-04-10-1502
@echo ----------------------------------------------------------
cd "%~dp0"
copy "Synergy_Error.exe" "C:\Program Files (x86)\Synergy\"
copy "Synergy.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\"
copy "Synergy_Error.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
@echo ----------------------------------------------------------
@echo :Skipsgc
@echo .
@echo You can close this windows.
@echo .
@Echo Name of the pc : !! %ComputerName% !!
@echo .
"C:\Program Files (x86)\Synergy\Synergy_Error.exe"
@exit
