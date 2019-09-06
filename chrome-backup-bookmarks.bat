@echo off
setlocal 
set msg="%TMP%\tempmsg.vbs"
ECHO WScript.Echo^( "Backup completing." ^) >%msg% 
start WSCRIPT.EXE /I /T:15 %msg%
del C:\Users\<user>\Desktop\bookmarks.txt
copy /A "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" C:\Users\<user>\Desktop\bookmarks.txt /Y