@echo off
cd /d %~dp0
adb -d shell mount -o remount rw /system > root