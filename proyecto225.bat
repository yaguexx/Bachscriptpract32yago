@echo off
:menu_principal
color b0
cls
echo ===============MENU PRINCIPAL===================
echo               1. Registrarse
echo              2. Iniciar Sesion
echo                  3. Salir
echo ================================================

set /p opcion="Seleccione una opcion: "

if "%opcion%"=="1" goto registrar
if "%opcion%"=="2" goto iniciar_sesion
if "%opcion%"=="3" exit

:registrar
cls
echo ==============Registro de Usuario================
set /p usuario="Ingrese un nombre de usuario: "
set /p pass="Ingrese una contrasena: "
set /p pass_confirm="Repita la contrasena: "

if "%pass%" neq "%pass_confirm%" (
    echo ================================================
    echo Las contrasenas NO coinciden. 
    echo Intente de nuevo
    echo ================================================
    pause
    goto registrar
)

REM Almacena el usuario y la contrasena en un archivo de texto 
echo %usuario%:%pass%>>usuarios.txt

echo ================================================
echo Usuario registrado con exito
echo ================================================
pause
goto menu_principal

:iniciar_sesion
cls
echo ===============Inicio de Sesion=================
set /p usuario="Ingrese su nombre de usuario: "

REM Verifica la existencia del usuario en el archivo
findstr /i /c:"%usuario%:" usuarios.txt >nul
if %errorlevel% neq 0 (
    echo ================================================
    echo Nombre de usuario no encontrado
    echo ================================================
    pause
    goto menu_principal
)

set /p pass="Ingrese su contrasena: "

REM Verifica la contrasena asociada al usuario
findstr /i /c:"%usuario%:%pass%" usuarios.txt >nul
if %errorlevel% neq 0 (
    echo ================================================
    echo Contrasena incorrecta
    echo ================================================
    pause
    goto menu_principal
)

echo                  **Bienvenido, %usuario%**

:opciones_usuario
echo ===============OPCIONES DE USUARIO==============
echo              a. Modificar contrasena
echo                b. Eliminar usuario
echo                  c. Cerrar sesion
echo ================================================

set /p opcion="Seleccione una opcion: "

if "%opcion%"=="a" goto modificar_contrasena
if "%opcion%"=="b" goto eliminar_usuario
if "%opcion%"=="c" goto menu_principal

:modificar_contrasena
cls
echo ================================================
set /p nueva_pass="Ingrese la nueva contrasena: "

REM Actualiza la contrasena en el archivo 
type usuarios.txt | find /v "%usuario%:" >temp.txt
echo %usuario%:%nueva_pass%>>temp.txt
move /y temp.txt usuarios.txt

echo ================================================
echo Contrasena modificada con exito
echo ================================================
pause
goto opciones_usuario

:eliminar_usuario
cls
REM Elimina la cuenta del usuario del archivo 
type usuarios.txt | find /v "%usuario%:" >temp.txt
move /y temp.txt usuarios.txt

echo ================================================
echo Usuario eliminado con exito
echo ================================================
pause
goto menu_principal
