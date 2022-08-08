@echo off

REM SHA1 sums of files required
REM xxxx *lrescue.1
REM xxxx *lrescue.2
REM xxxx *lrescue.3
REM xxxx *lrescue.4
REM xxxx *lrescue.5
REM xxxx *lrescue.6

set rom_path_src=..\roms\lrescue
set rom_path=..\build
set romgen_path=..\romgen_source

REM concatenate consecutive ROM regions
copy/b %rom_path_src%\lrescue.1 + %rom_path_src%\lrescue.2 + %rom_path_src%\lrescue.3 + %rom_path_src%\lrescue.4 %rom_path%\invaders_rom.bin > NUL
copy/b %rom_path_src%\lrescue.5 + %rom_path_src%\lrescue.6 %rom_path%\invaders_rom_2.bin > NUL

REM generate RAMB structures for larger ROMS
%romgen_path%\romgen %rom_path%\invaders_rom.bin INVADERS_ROM 13 l r e > %rom_path%\invaders_rom.vhd
%romgen_path%\romgen %rom_path%\invaders_rom_2.bin INVADERS_ROM_2 13 l r e > %rom_path%\invaders_rom_2.vhd

echo done
pause
