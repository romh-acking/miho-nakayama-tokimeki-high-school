arch nes.cpu

/////////////////////////////////////////////////////////////
// Constants (Pink Cursor)
/////////////////////////////////////////////////////////////

define cursor_p_X 				$C5
define cursor_p_Y 				$C6

//Name
define position1_X				#$58
define position1_Y				#$2f
define position1_last_X			#$B0

//Age
define position2_X				#$58
define position2_Y				#$3f

//Sex
define position3_X				#$b0

//Address #1
define position4_X				#$20
define position4_Y				#$5f
define position4_last_Y			#$d8

//Address #2
define position4_X				#$20
define position5_Y				#$6f
define position5_last_Y			#$d8

//Phone
define position6_X				#$58
define position6_Y				#$7f
define position6_last_X			#$B0

/////////////////////////////////////////////////////////////
// Pink Cursor alignment
/////////////////////////////////////////////////////////////

org $1723
LDA {position1_X}
STA {cursor_p_X}
LDA {position1_Y}
STA {cursor_p_Y}

org $1943
jsr $A70D

/////////////////////////////////////////////////////////////
// Pink Cursor: Movement "A" Button
/////////////////////////////////////////////////////////////

org $1A92
LDX {cursor_p_X}
LDY {cursor_p_Y}

CPY {position1_Y}
BNE branch_p_a
CPX {position1_last_X}
BNE branch_p_b
LDY {position2_Y}
LDX {position2_X}
JMP $BABD
 
branch_p_a:
CPY {position2_Y}
BNE branch_p_c
CPX #$58
BEQ branch_p_b
CPX #$60
BNE branch_p_d
LDX {position3_X}
JMP $BABD
 
branch_p_d:
LDY {position4_Y}
LDX #$20
JMP $BABD

branch_p_c:
CPY #$50
BNE branch_p_e
CPX #$70
BEQ branch_p_f
CPX #$88
BEQ branch_p_f
CPX #$D8
BNE branch_p_b
LDY {position4_Y}
LDX {position4_X}
JMP $BABD

branch_p_f:
TXA
CLC
ADC #$10
TAX
JMP $BABD

branch_p_e:
CPY {position4_Y}
BNE branch_p_g
CPX {position4_last_Y}
BNE branch_p_b
LDY {position5_Y}
LDX #$20
JMP $BABD
 
branch_p_g:
CPY {position5_Y}
BNE branch_p_h
CPX {position5_last_Y}
BNE branch_p_b
LDY {position6_Y}
LDX {position6_X}
JMP $BABD

branch_p_h:
CPX {position6_last_X}
BNE branch_p_b
LDY {position1_Y}
LDX {position1_X}
JMP $BABD

branch_p_b:
TXA

/////////////////////////////////////////////////////////////
// Pink Cursor: Free movement: UP (RAM: B947)
/////////////////////////////////////////////////////////////

org $1996; base $B947

ldx {cursor_p_X}
ldy {cursor_p_Y}
cpy {position1_Y}
bne branch_p_i
lda {position6_Y}
sta {cursor_p_Y}
rts

branch_p_i:
cpy #$5f
bne branch_p_j

cpx #$60
bcc branch_p_n2
cpx #$98
bcs branch_p_n
ldx #$60
jmp branch_p_k_2

branch_p_n:
ldx #$b0
jmp branch_p_k_2
 
branch_p_j:
jmp branch_p_k


branch_p_n2:
ldx #$58
jmp branch_p_k_2

nop
nop
nop
nop
nop
nop
nop

branch_p_k_2:
stx {cursor_p_X}
tya
sec
sbc #$20
sta {cursor_p_Y}
rts

branch_p_k:
stx {cursor_p_X}
tya
sec
sbc #$10
sta {cursor_p_Y}
rts

/////////////////////////////////////////////////////////////
// Pink Cursor: Free movement: Down (RAM: B98B)
/////////////////////////////////////////////////////////////

ldx {cursor_p_X}
ldy {cursor_p_Y}
cpy {position1_Y}
bne branch_p_o
cpx #$58
beq branch_p_p
cpx #$b0
beq branch_p_p

//if going from names to out of bounds area
//go to last age entry
ldx #$60
jmp $b9cc
 
branch_p_o:
cpy {position2_Y}
bne branch_p_q
nop
tya
clc
adc #$10
tay
jmp branch_p_p
 
branch_p_q:
cpy {position5_Y}
bne branch_p_r
cpx #$58
bcc branch_p_s
cpx #$b8
bcc branch_p_p
ldx #$b0
jmp branch_p_p
 
branch_p_s:
ldx #$58
jmp branch_p_p
 
branch_p_r:
cpy {position6_Y}
bne branch_p_p
lda {position1_Y}
sta $c6
rts

branch_p_p:
stx {cursor_p_X}
tya
clc
adc #$10
sta {cursor_p_Y}
rts

/////////////////////////////////////////////////////////////
// Pink Cursor: Free movement: Left (RAM: B9D5)
/////////////////////////////////////////////////////////////

ldx {cursor_p_X}
ldy {cursor_p_Y}
cpy {position1_Y}
bne branch_p_t
cpx #$58
bne branch_p_u
//Wraparound to end
ldy {position6_Y}
ldx #$b0
jmp $ba3e

branch_p_t:
cpy {position2_Y}
bne branch_p_w
cpx #$58
bne branch_p_v
ldy {position1_Y}
ldx #$b0
jmp $ba3e
 
branch_p_v:
cpx #$b0
bne branch_p_u
ldx #$60	//goto age
jmp $ba3e
 
branch_p_w:
cpy #$5f
bne branch_p_x
cpx #$20
bne branch_p_y
ldy #$3f
ldx #$b0
jmp $ba3e

branch_p_y:
cpx {position6_Y}
bne branch_p_z
ldx #$70
jmp $ba3e
 
branch_p_z:
cpx #$98
bne branch_p_u
ldx #$88
jmp $ba3e
 
branch_p_x:
cpx #$20
beq branch_p_a2
 
cpy {position6_Y}
bne branch_p_u
cpx #$58
bne branch_p_u

//wraparound for address field
branch_p_a2:
tya
sec
sbc #$10
tay
ldx #$d8
jmp $ba3e

branch_p_u:
txa
sec
sbc #$08
sta $c5
rts

sty {cursor_p_Y}
stx {cursor_p_X}
rts

 
/////////////////////////////////////////////////////////////
// Pink Cursor: Free movement: Right (RAM: BA43)
/////////////////////////////////////////////////////////////

ldx {cursor_p_X}
ldy {cursor_p_Y}
cpy #$2f
bne branch_p_b2
cpx #$b0
bne branch_p_c2
ldy #$3f
ldx #$58
jmp $babd
 
 
branch_p_b2:
cpy #$3f
bne branch_p_x2
cpx #$58
beq branch_p_c2
cpx #$60
bne branch_p_d2
ldx #$b0
jmp $babd

branch_p_d2:
ldy #$5f
ldx #$20
jmp $babd

branch_p_x2:
cpy #$50
bne branch_p_e2
cpx #$70
beq branch_p_f2
cpx #$88
beq branch_p_f2
cpx #$d8
bne branch_p_c2
ldy #$5f
ldx #$20
jmp $babd
 
branch_p_f2:
txa
clc
adc #$10
tax
jmp $babd
 
branch_p_e2:
cpy #$5f
bne branch_p_g2
cpx #$d8
bne branch_p_c2
ldy #$6f
ldx #$20
jmp $babd

branch_p_g2:
cpy #$6f
bne branch_p_h2
cpx #$d8
bne branch_p_c2
ldy #$7f
ldx #$58
jmp $babd
 
branch_p_h2:
cpx #$b0
bne branch_p_c2
ldy #$2f
ldx #$58
jmp $babd
 
branch_p_c2:
txa
clc
adc #$08
sta $c5
rts
stx $c5
sty $c6
rts