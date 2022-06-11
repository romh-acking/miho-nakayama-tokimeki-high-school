::Folders
set projectFolder=%cd%
set spiroFolder=%projectFolder%\tools\spiro
set fdsBuilderFolder=%projectFolder%\tools\fdsBuilder
set xkasFolder=%projectFolder%\tools\xkas

::It's used to manage the files in one place so we only need to specify one path to read and write from
set diskDirectory=%projectFolder%\disks

::Roms
set baseImage=%projectFolder%\roms\Idol Hotline - Nakayama Miho no Tokimeki High School (Japan) (DV 10).fds
set translatedRom=%projectFolder%\roms\Idol Hotline - Nakayama Miho no Tokimeki High School (NEW2).fds

cd "%projectFolder%"

::Expand FDS rom
del "%translatedRom%"
del %diskDirectory%

"%fdsBuilderFolder%\FDSBuilderC-Sharp.exe" ^
--inputDiskImage "%baseImage%" ^
--extract ^
--expand ^
--expansionSettingsPath "%projectFolder%\expansion.json" ^
--diskDirectory "%diskDirectory%"

::Insert script
"%spiroFolder%\Spiro.exe" /ProjectDirectory "%projectFolder%" /WriteScriptToROM

"%fdsBuilderFolder%\FDSBuilderC-Sharp.exe" ^
--inputDiskImage "%baseImage%" ^
--outputDiskImage "%translatedRom%" ^
--merge "%diskDirectory%" ^
--diskDirectory "%diskDirectory%"

::Apply ASM patches
"%xkasFolder%\xkas+.exe" -o "%translatedRom%" "asm\Dictionary.asm" "asm\Name.asm" "asm\Graphics.asm" "asm\Screen.asm" "asm\Misc Text.asm" "asm\cursors\Disk Fax Blue Cursor.asm" "asm\cursors\Disk Fax Pink Cursor.asm" "asm\cursors\Name Green Cursor.asm" "asm\cursors\Welcome Screen Pink Cursor.asm" "asm\Credits.asm" "asm\Single Spacing.asm"

"%translatedRom%"
::@pause