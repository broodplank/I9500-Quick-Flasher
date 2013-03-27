@echo off
cd /d %~dp0
adb -d shell cat '/system/xbin/su' > su