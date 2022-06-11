arch nes.cpu

define 	ppudata_2007	0x2007

/////////////////////////////////////////////////////////////
// Name fix
/////////////////////////////////////////////////////////////
//Convert name digest to script digest.
org $15c5; base 0xB576
jmp $A6BB
nop
nop
nop

org $70a; base 0xA6BB
lda $2007
lda $2007

cmp #$20
beq out
sbc #$af
jmp $B57C
out:
lda #$ff
jmp $B57C

org $15cd
CMP #$ff

/////////////////////////////////////////////////////////////
// Name screen character limit increase (FCandChill)
/////////////////////////////////////////////////////////////

//Change the left limit on the screen since we shifted left
//This is for when deleting characters you entered.
org $1451
db $60

//Below is code to change how the game reads the players name


//Change where in the PPU to start reading the name
org $15A4
lda #$ec

//Adjust PPU reading boundary to load whole name
org $1600
cmp #$F4

/////////////////////////////////////////////////////////////
// Name screen character limit increase (Pennywise)
/////////////////////////////////////////////////////////////
org $153D
db $0C


//-------------
//Shift to the left
//-------------
org $13DE
db $60


//-------------
//???
//-------------
org $140C
db $A0

//-------------
//???
//-------------

org $1535
db $A0

//-------------
//???
//-------------
org $152F 
JSR $A6FD

org $74C
sta $0210
sta $0214
sta $0218
sta $021C
sta $0220
rts

//-------------
//Makes it so 8 hearts display
//------------- 

org $1545; base $B4F6
branch_Heart8_1:
lda #$38
sta $0200,x
inx
inx
inx
inx
cpx #$24
bcc branch_Heart8_1
lda $ca
cmp #$10

bcc branch_Heart8_2
lda #$f0
sta $0200,y

branch_Heart8_2:
lda #$00
ldx #$00

branch_Heart8_3:
sta $0205,x
inx
inx
inx
inx
cpx #$20
bcc branch_Heart8_3
jsr Whatever
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
ldx #$07
lda #$60
sta $0200,x
clc
adc #$08
inx
inx
inx
inx
cpx #$2b

//-------------
//Move hearts up one pixel
//------------- 

org $1545; base $B4F6
LDA #$37

//-------------
//Whatever (Item free space)
//------------- 
org $73c; base $A6ED

Whatever:
lda #$02
ldx #$00
branch_w2:
sta $0206,x
inx
inx
inx
inx
cpx #$20
bcc branch_w2
rts
