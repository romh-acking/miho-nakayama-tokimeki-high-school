arch nes.cpu

define PpuAddr_2006				0x2006
define PpuData_2007				0x2007
define LineLocations			0xb07d

/////////////////////////////////////////////////////////////
// Miho's message
/////////////////////////////////////////////////////////////

//Remove double spacing
org 0x00001f2d; base $BEDE
adc #$20

// Increase text speed
org 0x00001F83; base $BF34; fill 0x3,0xEA

/////////////////////////////////////////////////////////////
// Adjust linebreaking to support more lines
/////////////////////////////////////////////////////////////

org 0x00004A16; base 0x6FEE; fill 0x27, 0xEA
org 0x00004A16; base 0x6FEE
LineBreakFunc:

lda 0xB192
ldy #$00

LineBreakLoop:
iny
cmp LineLength,y
bcs LineBreakLoop

lda LineLength,y
sta 0xB192
rts

LineLength:
db 0x00,0x16,0x2C,0x42,0x58,0x6E,0x84,0x9A,0xB0,0xC6,0xDC

LineNumber:
db 0x7,0x06,0x05,0x04,0x03,0x02,0x01,0x00

/////////////////////////////////////////////////////////////
// Adjust page size (parsing)
/////////////////////////////////////////////////////////////

org 0x00004A0C; base 0x6FE4
cmp #$9A

/////////////////////////////////////////////////////////////
// Text
/////////////////////////////////////////////////////////////

org 0x00005AF8; base 0x80D0; fill 0x90, 0xEA
org 0x00005AF8; base 0x80D0
PrintText:
// Calculate line number
tax
lda LineNumber,x
sta $12

lda 0xB194
cmp #$08
bcs PrintSkip

lda $12
asl
adc #$02
tax
lda $7b76,x
sta {PpuAddr_2006}
lda $7b77,x
sta {PpuAddr_2006}

// Get indexer
lda $12
tax
lda LineLength,x
tax

// Write text
ldy #$16
PrintLoop:
lda {LineLocations},x
sta {PpuData_2007}

inx
dey
bne PrintLoop

PrintEnd:

lda #$00
sta $2005
sta $2005
lda #$10
sta $2000
dec $b194
//dec $b194
rts

// Skip a lot of runs to prevent needless delays
// We're only printing in a couple of runs
PrintSkip:
lda #$07
sta $b194
jmp PrintText
