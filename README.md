[//]: <> (This readme is in the markdown format. Please preview in a markdown parser.)

# Miho Nakayama's Tokimeki High School: English Translation

## About
This repository contains source code for patches and tools to compile an English translation of Miho Nakayama's Tokimeki High School.

## Folders

* asm
	* Contains the asm files which are to be compiled with xkas
* lua
    * Some lua scripts.
* roms
	* Use this to store your ~~roms~~ disk images
* script
	* Contains the dump script in Script.json. It contains the Japanese script and the English translation.
	* You can also store xlsx backups of the script here.
* tables
	* Contains table files
		* Files prefixed with "CHR" specify byte to character mapping.
		* Files prefixed with "Dictionary" specify dictionary mapping. A dictionary can be mapped to multiple character values.
		* Files with "Length" let you specify how wide, in pixels, characters are. This affects `spiro.exe`'s autolinebreaking logic. For a game without VWF, most characters should have a length of `8`. 
* tools
	* cyproAce
		* A script editor 
	* spiro
		* Script dumper and inserter
	* xkas
		* Applies the assembly patches
    * [fdsBuilder](https://github.com/romh-acking/fdsbuilderc-sharp)
        * A tool to extract FDS files, expand, and create disk images.

## Manual and Hotline Flyer
* [miho-nakayama-tokimeki-high-school-manual](https://github.com/romh-acking/miho-nakayama-tokimeki-high-school-manual)
* [miho-nakayama-tokimeki-high-school-hotline-flyer](https://github.com/romh-acking/miho-nakayama-tokimeki-high-school-hotline-flyer)

## Instructions
The tools are coded in C#. You'll have to mess with Wine if you want them to run in Linux. You'll also have to rewrite the bat files, which aren't complicated at all.

* If you want to dump the script for whatever reason (the Japanese and English script are already included in this repository), you can dump it by executing the bat file "Dump.bat" by double clicking it.
* Execute the bat file "Write.bat" by double clicking it, to generate a translated FDS disk image file.
    * The script assumes there's a file in the `rom` folder called `Idol Hotline - Nakayama Miho no Tokimeki High School (Japan) (DV 10).fds`.

### Translation Notes
The development team is willing to provide guidance and assistance for other translation projects, however, we ask that you at least have basic technical skills, knowledge about romhacking (6502 assembly language knowledge, the capability to use a debugger, etc.), and the ability to ask intelligence questions.

## Changelog
* 2022 June 11th: 1.0
    * Initial release

## Credits

### Main Team
* FCandChill
    * Project lead
    * Advanced ASM hacking
    * Utilities
    * Proofreader
	* Manual and flyer editing
	* Vectorized version of Graphicus's title screen
* filler
    * Initial script dump
    * Translation
    * Initial hacking and resources
* TheMajinZenki
    * Proofreader
    * Accuracy checks
    * Manual and flyer translator
* Graphicus
    * Title screen

### Support
* Pennywise
    * Some ASM work
    * Guidance / inspiration
* KingMike
    * Hacking
    * Guidance
* Spinner8
    * Hacking
    * Guidance
* Hubz
    * Manual scan from Gaming Alexandria
* Eien Ni Hen
    * On-spot translations
* Tom
    * On-spot translation
* Disch
    * Guidance for address conversion handling

### Beta Testers
* cccmar
* ppltoast
