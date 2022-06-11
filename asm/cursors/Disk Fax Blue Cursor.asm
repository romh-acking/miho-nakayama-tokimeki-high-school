arch nes.cpu

define b_wraparound_topY 		#$97
define b_wraparound_leftX 		#$28
define b_wraparound_bottomY 	#$bf
define b_wraparound_rightX 		#$D0

define b_marker_nulled 			#$00

define cursor_b_X 				$C7
define cursor_b_Y 				$C8

/////////////////////////////////////////////////////////////
// Disk Fax - Menu
/////////////////////////////////////////////////////////////

//Pennywise
//Make all character selectable
org $181C
nop

//Removing cursor jump
org $1c13
adc #$08

//Delete reference for Write0To9 function.
org $1E04
jsr $BE0C

//Change where the address is read because we shortened the field
//Indicates where in PPU the address is read.
//Originally $4c
org $3752
db $84

//Delete reference for Read0To9 function.
org $1790; fill $06, $ea

//Don't know what this does exactly, but it prevents
//a japanese character being loaded onscreen with my changes.
org $cfba
db $ff

/////////////////////////////////////////////////////////////
// Disk Fax - Cursor
/////////////////////////////////////////////////////////////

//--------------------
//Cursor alignment
//--------------------
org $172f
lda #$97

org $190b
jsr $A70D

//jump to space we freed up in the items
org $75C
adc #$01
sta $0002
rts

//--------------------
//Remove Highlighting
//--------------------

//Special Options
org $1C94
ldx {cursor_b_X}
ldy {cursor_b_Y}
cpy {b_marker_nulled}
bne branch_a1
cpx {b_marker_nulled}
beq branch_b1
cpx {b_marker_nulled}
beq branch_b1
cpx {b_marker_nulled}
beq branch_c1
jmp $BC77
 
branch_a1:
cpy #$bf		//Save
bne branch_d1
cpx {b_marker_nulled}
beq branch_c1
cpx #$b8		//Save
bne branch_d1
ldy #$04
jmp $BC79
 
branch_b1:
ldy #$02
jmp $BC79
branch_c1:
ldy #$03
jmp $BC79
branch_d1:
ldy #$01
branch_e1:
ldx #$04

//--------------------
//Blue cursor movement: RIGHT
//--------------------

org $1bde; base $BB8F
LDX {cursor_b_X}
LDY {cursor_b_Y}
CPX #$48
BEQ branch_skipRight1
CPX #$78
BEQ branch_skipRight1
CPX {b_marker_nulled}
BNE branch_b2
CPX {b_marker_nulled}
BEQ branch_skipRight1
CPX #$A0
BEQ branch_skipRight1
CPX #$B8
BEQ branch_skipRight3
 
branch_b2:
CPY #$bf
BNE branch_e2
CPX {b_marker_nulled}
BEQ branch_skipRight3
CPX #$B8
BEQ branch_wraparound2
branch_e2:
CPX {b_wraparound_rightX}
BEQ branch_wraparound2
TXA
CLC
ADC #$08
STA $C7
RTS
 
branch_skipRight1:
TXA
CLC
ADC #$08
STA $C7
RTS

branch_skipRight3:
TXA
CLC
ADC #$18
STA $C7
RTS

branch_wraparound2:
LDA #$28
STA $C7
RTS

//--------------------
//Blue cursor movement: DOWN
//--------------------

org $1b46; fill $4d, $ea

org $1b46; base $BAF7

LDX {cursor_b_X}
LDY {cursor_b_Y}
CPY #$bf
BNE branch_e3
LDA #$97
STA $C8
RTS

branch_e3:
 
branch_b3:
CPY #$B7
BNE branch_d3
CPX #$D0
BEQ branch_3_pass
CPX #$c8
BEQ branch_3_pass
CPX #$c0
BEQ branch_3_pass
CPX #$b8
BEQ branch_3_pass
JMP branch_d3
branch_3_pass:
LDA #$B8
STA $C7
JMP branch_d3

branch_a3:
TXA
SEC
SBC #$08
STA $C7
JMP branch_d3

branch_c3:
TXA
SEC
SBC #$10
STA $C7

branch_d3:
TYA
CLC
ADC #$08
STA $C8
RTS


//--------------------
//Blue cursor movement: LEFT
//--------------------

org $1B93; base $BB44
ldx {cursor_b_X}
ldy {cursor_b_Y}
cpy {b_marker_nulled}
bne branch_b_a4
cpx {b_marker_nulled}
beq branch_b_b4
cpx #$b0
beq branch_b_c4
cpx #$98
beq branch_b_c4

branch_b_a4:
cpy #$bf
bne branch_b_d4
cpx {b_marker_nulled}
beq branch_b_b4
cpx {b_wraparound_leftX}
bne branch_b_d4
lda #$b8	
sta {cursor_b_X}
rts
 
branch_b_d4:
cpx {b_marker_nulled}
beq branch_b_c4
cpx {b_marker_nulled}
beq branch_b_c4
cpx #$28
beq branch_b_e4
txa
sec
sbc #$08
sta {cursor_b_X}
rts

branch_b_c4:
txa
sec
sbc #$10
sta {cursor_b_X}
rts
 
branch_b_b4:
txa
sec
sbc #$18
sta {cursor_b_X}
rts

branch_b_e4:
lda #$d0
sta {cursor_b_X}
rts

//--------------------
//Blue cursor movement: UP (RAM: BAC2)
//--------------------

org $1b11; base $BAC2
ldx {cursor_b_X}
ldy {cursor_b_Y}
cpy {b_wraparound_topY}
bne branch_b_a5
lda #$bf
sta {cursor_b_Y}
cpx #$b8
bcc branch_b_b5
lda #$b8	//wraparound
sta {cursor_b_X}
branch_b_b5:
rts

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
nop
nop
nop

branch_b_a5:
cpy #$bf
bne branch_b_e5
cpx #$a8
bne branch_b_e5
lda #$a0
sta {cursor_b_X}
 
branch_b_e5:
tya
sec
sbc #$08
sta {cursor_b_Y}
rts


//--------------------
//Save Check
//--------------------

org $1802
LDA {cursor_b_Y}
CMP #$bf


/////////////////////////////////////////////////////////////
//Disk saving
/////////////////////////////////////////////////////////////

//--------------------
//PPU read locations
//--------------------

org $3745
db $22,$0B //Phone
db $0C	   //Length (and for all others)

db $20,$CB //Name
db $0C

db $21,$0B //Age
db $02

db $21,$16 //Gender
db $01

db $21,$84 //Address (Part 1) (Unused)
db $01 //db $06

db $21,$53 //Address (Part 2) (Unused)
db $01 //db $09

db $21,$84 //Address (Part 3)
db $18

db $21,$C4 //Address (Part 4)
db $18

//--------------------
//Limit 
//--------------------
//The amount tiles to read
org $1E0F
cmp #$4D
