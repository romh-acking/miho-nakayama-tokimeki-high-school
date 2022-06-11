arch nes.cpu

define cursor_g_X 				$C5
define cursor_g_Y 				$C6
define name_loc					$C7
define NULL						#$00

/////////////////////////////////////////////////////////////
// Cursor Alignment
/////////////////////////////////////////////////////////////
org $13D1
lda #$4f

/////////////////////////////////////////////////////////////
// Green Cursor - A (RAM: B3A7)
/////////////////////////////////////////////////////////////
org $13F6
jsr $A713
nop
ldx {name_loc}
cpy #$c0
bne branch_a_1
cmp #$b0
bne branch_a_1

//Check if name entry is empty
cpx #$60	//starting position of cursor
beq branch_a_out
inc $c4		//indicates to transition to next screen
rts
 
branch_a_1:
cpx #$a0
beq branch_a_out
sty $0002
clc
adc #$08
sta $0003
jsr $e97d
lda $0000
sta $e7
lda $0001
sta $e6
lda $c8
sta $0002
lda {name_loc}
sta $0003
jsr $e97d
lda $0000
sta $e5
lda $0001
sta $e4
lda {name_loc}
clc
adc #$08
sta {name_loc}
lda #$3a
sta $af6d
lda #$b0
sta $af6e
 
branch_a_out:
rts
 
 
//Goto space we freed up after item names ("A713")
//adjust cursor Y because it assumes its a pixel lower
//(we raised it to align with the new font)
org $762
LDY {cursor_g_Y}
iny
LDA {cursor_g_X}
rts

//Don't write anything if selecting our special character
//"1E". It looks like a space in-game, but it's stored as "#"
//in our table file.
org $10a9
CMP #$1E
BNE branch_wa
lda {name_loc}
sbc #$08
sta {name_loc}
rts
NOP
NOP
NOP
NOP
NOP
branch_wa:

/////////////////////////////////////////////////////////////
// Green Cursor - UP (RAM: B432-B44C)
/////////////////////////////////////////////////////////////

org $1481
lda {cursor_g_Y}
cmp #$4f
bne branch_up1
lda #$bf
sta {cursor_g_Y}
lda {cursor_g_X}
cmp #$c0
bne branch_up2
lda #$b0
sta {cursor_g_X}
rts
branch_up1:
sec
sbc #$10
sta {cursor_g_Y}
branch_up2:
rts

/////////////////////////////////////////////////////////////
// Green Cursor - DOWN (RAM: B44D-B46F)
/////////////////////////////////////////////////////////////
lda {cursor_g_Y}
cmp #$bf
bne branch_down1
lda #$4f
sta {cursor_g_Y}
rts
branch_down1:
cmp #$af
beq branch_down3
cmp {NULL}
bne branch_down2
 
branch_down3:
ldx $c5
cpx #$c0
bne branch_down2
ldx #$b0
stx $c5
 
branch_down2:
clc
adc #$10
sta {cursor_g_Y}
rts
 
/////////////////////////////////////////////////////////////
// Green Cursor - Left (RAM: B470-B492)
/////////////////////////////////////////////////////////////
lda {cursor_g_X}
cmp #$80
bne branch_right1
lda #$68
sta {cursor_g_X}
rts 
 
branch_right1:
cmp #$28
bne branch_right2
lda {cursor_g_Y}
cmp {NULL}
beq branch_right3
cmp #$bf
bne branch_right4
 
branch_right3:
lda #$b0
sta {cursor_g_X}
rts
 
branch_right4:
lda #$c0
sta {cursor_g_X}
rts

branch_right2:
sec
sbc #$10
sta {cursor_g_X}
rts

/////////////////////////////////////////////////////////////
// Green Cursor - Right (RAM: B499-B4C0)
/////////////////////////////////////////////////////////////

lda {cursor_g_X}
cmp #$68
bne branch_left1
lda #$80
sta {cursor_g_X}
rts
branch_left1:
cmp #$c0
bne branch_left2
branch_left5:
lda #$28
sta {cursor_g_X}
rts
branch_left2:
ldx {cursor_g_Y}
cpx {NULL}
beq branch_left3
cpx #$bf
bne branch_left4
branch_left3:
cmp #$b0
beq branch_left5
 
branch_left4:
clc
adc #$10
sta {cursor_g_X}
rts
