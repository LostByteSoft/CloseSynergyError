cd "%~dp0"
@taskkill /f /im "Synergy_Error.exe"
@echo Version 2018-04-10-1511
@echo ----------------------------------------------------------
@echo No lnk in install.
"SynergyInstaller-1.3.1.exe"
if exist "%userprofile%\Documents\synergy.sgc" goto skipsgc
copy synergy.sgc "%USERPROFILE%\Documents\"
:skipsgc
attrib -r -a -s -h "C:\Users\Master\Documents\synergy.sgc"
attrib +h "C:\Users\Master\Documents\synergy.sgc"
@echo ----------------------------------------------------------
@exit
