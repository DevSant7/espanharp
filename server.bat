@echo off
color 6
echo ---------------------------------------------------
echo BASE DESENVOLVIDA POR: kernel e Miiler
echo ___________________________________________________

timeout 5
cls

cd /d "C:\Users\rique\OneDrive\Documentos\espanha-roleplay\espanha-roleplay\server"
..\artifacts\FXServer.exe +set onesync on +set onesync_population true +exec "C:\Users\rique\OneDrive\Documentos\espanha-roleplay\espanha-roleplay\server\server.cfg"
pause