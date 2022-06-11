arch nes.cpu

// nindb.net/nes/tokimeki-high-school/guide.html
//Regex
//(?<!:)(\[LINE\])
//Match on all linebreaks except for namecards

//Format hex to ASM db thing
//Find: [0-9A-Z][0-9A-Z]
//Replace: ,\$$&
//Replace example: xxxxxxxxx$&xxxxxxxxx

define newPageControlCode 		#$FD

/////////////////////////////////////////////////////////////
// Dictionary
/////////////////////////////////////////////////////////////

//Relocate where the game reads the dictionary.
org $4c0f
LDA #$50
STA $01
LDA #$05
STA $02

//Relocate dictionary in RAM
org $7b32
db $50, $05

//Repoint name writing in RAM:
//The name writing comes BEFORE
//dictionary writing, so the dictionary can overwrite
//the name.
org $4e4
db $f7, $07

/////////////////////////////////////////////////////////////
// Dialogue ASM
/////////////////////////////////////////////////////////////
// Dialogue load
// 6EF9  $A1 $01      LDA ($01,X) @ $8E79             A:00 X:00 Y:01 P:03 SP:F5 CYC:226 SL:22

//NOP out special case for katana characters
//as well as some other stuff
org $495a; fill $37, $ea

org $495a; base $6F32
cmp #$00 //branch if not newline byte
bne branch_ea

JSR $6FEE
INC $0001
BNE branch_eb
INC $0002
branch_eb:
JMP $6FE1

branch_ea:
cmp #$31
bcc branch_ec

cmp {newPageControlCode}
beq NewPage

jsr Dictionary
branch_ec:
sec
adc #$5e
jmp Skip

NewPage:
jsr jsr_NewPage

Skip:

/////////////////////////////////////////////////////////////
// Dictionary ASM
/////////////////////////////////////////////////////////////

org $4bf7; base $71CE
Dictionary:
sbc #$30

/////////////////////////////////////////////////////////////
// New Page control code
/////////////////////////////////////////////////////////////

org $4A83; base $705B; fill $AF, $ea

org $4A83; base $705B
jsr_NewPage:

// One less than the value at "Adjust page size (parsing)"
lda #$99
sta $B192

lda #$24
rts

