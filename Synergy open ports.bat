cd "%~dp0"
@echo Version 2018-04-10-1511
@echo ----------------------------------------------------------
rem Open UDP Port 24800 inbound and outbound
netsh advfirewall firewall add rule name="Synergy C 24800 UDP" program="C:\Program Files (x86)\Synergy\synergyc.exe" dir=in action=allow protocol=UDP localport=24800
netsh advfirewall firewall add rule name="Synergy S 24800 UDP" program="C:\Program Files (x86)\Synergy\synergys.exe" dir=in action=allow protocol=UDP localport=24800
netsh advfirewall firewall add rule name="Synergy C 24800 UDP" program="C:\Program Files (x86)\Synergy\synergyc.exe" dir=out action=allow protocol=UDP localport=24800
netsh advfirewall firewall add rule name="Synergy S 24800 UDP" program="C:\Program Files (x86)\Synergy\synergys.exe" dir=out action=allow protocol=UDP localport=24800
rem Open TCP Port 24800 inbound and outbound
netsh advfirewall firewall add rule name="Synergy C 24800 TCP" program="C:\Program Files (x86)\Synergy\synergyc.exe" dir=in action=allow protocol=TCP localport=24800
netsh advfirewall firewall add rule name="Synergy S 24800 TCP" program="C:\Program Files (x86)\Synergy\synergys.exe" dir=in action=allow protocol=TCP localport=24800
netsh advfirewall firewall add rule name="Synergy C 24800 TCP" program="C:\Program Files (x86)\Synergy\synergyc.exe" dir=out action=allow protocol=TCP localport=24800
netsh advfirewall firewall add rule name="Synergy S 24800 TCP" program="C:\Program Files (x86)\Synergy\synergys.exe" dir=out action=allow protocol=TCP localport=24800
@echo ----------------------------------------------------------
@exit
