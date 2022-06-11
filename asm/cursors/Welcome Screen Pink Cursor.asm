arch nes.cpu

define cursor_g_X 				$C5
define cursor_g_Y 				$C6

define top_margin 				#$8f
define bottom_margin 			#$bf

/////////////////////////////////////////////////////////////
// Welcome screen - Cursor default position
/////////////////////////////////////////////////////////////

org $12b6; base $B267
lda #$68
sta {cursor_g_X}
lda #$8f
sta {cursor_g_Y}

/////////////////////////////////////////////////////////////
// Welcome screen - DOWN (RAM: $b28f)
/////////////////////////////////////////////////////////////

org $12de; base $b28f
lda {cursor_g_Y}
cmp {bottom_margin}
bcc welcome_branch_d1
lda {top_margin}
sta {cursor_g_Y}
rts

welcome_branch_d1:
adc #$10
sta $c6
rts

/////////////////////////////////////////////////////////////
// Welcome screen - UP (RAM: $B29F)
/////////////////////////////////////////////////////////////

lda {cursor_g_Y}
cmp {top_margin}
bne welcome_branch_u1
lda {bottom_margin}
sta {cursor_g_Y}
rts
 
welcome_branch_u1:
sec
sbc #$10
sta {cursor_g_Y}
rts

/////////////////////////////////////////////////////////////
// Welcome screen - A
/////////////////////////////////////////////////////////////

org $1314; base $B2C5
lda {cursor_g_Y}
cmp #$9f
bne $b2f0
lda $80b0
cmp #$ff
bne welcome_branch_a4
lda #$8f
sta {cursor_g_Y}
rts
welcome_branch_a4:

org $E63; base $AE14
welcome_branch_a2:
JSR $B1FA
LDA {cursor_g_Y}
CMP #$8f
BNE welcome_branch_a1
JSR $B2F1
LDA $C4
BNE welcome_branch_a2
JMP $AE48

welcome_branch_a1:
CMP #$9f
BNE welcome_branch_a3
JMP $AE48
welcome_branch_a3:
CMP #$af
