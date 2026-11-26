if not exist autounattend.xml (
msg %username% copiez autounattend.xml ici
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Export-UnattendScripts.ps1"
pause
