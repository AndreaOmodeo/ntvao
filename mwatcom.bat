@echo off
setlocal
SET WATCOM=C:\WATCOM
SET PATH=%WATCOM%\BINNT64;%WATCOM%\BINNT;%PATH%
SET EDPATH=%WATCOM%\EDDAT
SET INCLUDE=%WATCOM%\H;%WATCOM%\H\NT;..\djl

wcl -q -zp=1 -ml -obmr -oh -ei -oi -s -0 -xs -j -oe=160 -ol+ -ot ntvao.cxx mos6502.cxx -bcl=DOS -k8192 -fe=ntvaodos.exe /DWATCOM /DNDEBUG

