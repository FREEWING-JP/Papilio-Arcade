@echo off

REM SHA1 sums of files required
REM xxxx *invaders.h
REM xxxx *invaders.f
REM xxxx *invaders.e
REM xxxx *invaders.g

set rom_path_src=..\roms\invaders
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\invaders.h + %rom_path_src%\invaders.g + %rom_path_src%\invaders.f + %rom_path_src%\invaders.e %rom_path%\invaders_rom.bin > NUL

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\invaders_rom.bin INVADERS_ROM 13 l r e > %rom_path%\invaders_rom.vhd

echo done
pause
