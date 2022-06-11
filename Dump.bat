::Folders
set projectFolder=%cd%
set spiroFolder=%projectFolder%\tools\spiro
set fdsBuilderFolder=%projectFolder%\tools\fdsBuilder
set diskDirectory=%projectFolder%\disks

::Roms
set baseImage=%projectFolder%\roms\Idol Hotline - Nakayama Miho no Tokimeki High School (Japan) (DV 10).fds

cd "%projectFolder%"

::Extract FDS files
"%fdsBuilderFolder%\FDSBuilderC-Sharp.exe" ^
--inputDiskImage "%baseImage%" ^
--extract ^
--diskDirectory "%diskDirectory%"

::Dump script
"%spiroFolder%\Spiro.exe" /ProjectDirectory "%projectFolder%" /DumpScript /Verbose
@pause