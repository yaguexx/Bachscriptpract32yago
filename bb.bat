@echo off
setlocal enabledelayedexpansion

set "primerdirectorio=C:\Users\Alumno 24\Desktop\ISO
set "segundodirectorio=C:\Users\Alumno 24\Desktop

for %%F in ("%primerdirectorio%\*.txt") do (
copy "%%F" "%segundodirectorio%"
echo Archivo copiado: %%~nxF
)
endlocal

pause