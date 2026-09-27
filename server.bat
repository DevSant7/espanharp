@echo off
color 6
echo ---------------------------------------------------
echo BASE DESENVOLVIDA POR: kernel e Miiler
echo ___________________________________________________

timeout 5
cls

cd /d "C:\Users\Administrator\Documents\espanharp\server"

"..\artifacts\FXServer.exe" +set onesync on +set onesync_population true +exec "server.cfg"

pause