arch nes.cpu

define 	ppustatus_2002	0x2002
define 	ppuaddr_2006	0x2006
define 	ppudata_2007	0x2007

/////////////////////////////////////////////////////////////
// Second line Printing (Credits)
/////////////////////////////////////////////////////////////
org $720; base 0xA6D1
ConvertScript:
lda (0xA0),y
clc
adc #$af
STA {ppudata_2007}
jmp ConvertScriptOut

/////////////////////////////////////////////////////////////
// First line Printing (Credits)
/////////////////////////////////////////////////////////////
ConvertScript1:
lda (0xA0),y
clc
adc #$af
STA {ppudata_2007}
jmp ConvertScript1Out

/////////////////////////////////////////////////////////////
// Second line Printing (Credits)
/////////////////////////////////////////////////////////////

org 0x7478; base $9A50; fill 0x5, 0xea
org 0x7478; base $9A50
jmp ConvertScript
ConvertScriptOut:

/////////////////////////////////////////////////////////////
// Relocate text writing
/////////////////////////////////////////////////////////////

// Credits buffer start: B66F

// Place first line in diatric area

// load indentation from script entry.
// 970F  $B1 $90      LDA ($90),Y @ $BB08             A:BB X:B6 Y:00 P:02 SP:FB CYC:266 SL:23
// 9711  $AA          TAX                             A:01 X:B6 Y:00 P:00 SP:FB CYC:281 SL:23

org 0x00007157; base $972F
sta 0xB66F,x

/////////////////////////////////////////////////////////////
// First line printing
/////////////////////////////////////////////////////////////

org 0x00007427; base $99FF; fill 0x23, 0xEA
org 0x00007427; base $99FF

bit {ppustatus_2002}
lda $b66e
sta {ppuaddr_2006}
lda $b66d
sta {ppuaddr_2006}

lda #$6f
sta $a0
lda #$b6 
sta $a1
ldy #$00

PrintFirstLine:
jmp ConvertScript1
ConvertScript1Out:
iny
cpy #$20
bcc PrintFirstLine

///////////////////////////////////
// Reading script
///////////////////////////////////
org 0x0000713D; base $9715; fill 0x22, 0xEA
org 0x0000713D; base $9715

ScriptReadStart:
lda ($90),y
cmp #$ff 
beq ScriptReadEnd

cmp #$E0 
bcs ScriptReadSpacesControlCode 

jmp ScriptReadStoreChar
ScriptReadSpacesControlCode:
sbc #$DF
sta $A0
txa
adc $A0
tax
jmp ScriptReadStoreCharA

ScriptReadStoreChar:
sta $b66f,x
inx

ScriptReadStoreCharA:
iny
jmp ScriptReadStart
ScriptReadEnd: 

/////////////////////////////////////////////////////////////
// Change blank character
/////////////////////////////////////////////////////////////
org 0x00007123
lda #$21

/////////////////////////////////////////////////////////////
// Nintendo Logo
/////////////////////////////////////////////////////////////

table "asm/tbl/GameFont.tbl"

org 0x000071eF
db "           PUSH START",0xFF

org 0x00007226
db "             ",0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,"   ",0xFF
