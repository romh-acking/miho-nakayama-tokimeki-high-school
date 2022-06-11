arch nes.cpu

/////////////////////////////////////////////////////////////
// Menu Text
/////////////////////////////////////////////////////////////
table "asm/tbl/GameFont.tbl"

//One pointer is loaded then incremented by ADC #$10
//00:916F:A9 49     LDA #$49
//00:9171:85 02     STA $0002 = #$49
//00:9173:A9 8D     LDA #$8D
//00:9175:85 03     STA $0003 = #$00
//00:9177:A5 04     LDA $0004 = #$03
//00:9179:F0 12     BEQ $918D
//00:917B:A5 02     LDA $0002 = #$49
//00:917D:18        CLC
//00:917E:69 10     ADC #$10

org $6771
db "ITEMS",$ff,$00
org $6781
db "1SAVE1LOADS",$ff,$00
org $6791
db "MOVE",$ff,$00
org $67a1
db "EXAMINE",$ff,$00
org $67b1
db "TAKE",$ff,$00
org $67c1
db "1PUSH1PULL",$ff,$00
org $67d1
db "TOUCH",$ff,$00
org $67e1
db "HIT",$ff,$00
org $67f1
db "OPEN",$ff,$00
org $6801
db "A",$ff,$00
org $6811
db "B",$ff,$00
org $6821
db "C",$ff,$00
org $6831
db "USE",$ff,$00
org $6841
db "GIVE",$ff,$00
org $6851
db "SHOW",$ff,$00
org $6861
db "ITEMS",$ff,$00
org $6871
db "TALK",$ff,$00
org $6881
db "PUSH A",$ff
org $6891
db "MOVE",$ff,$00
org $68A1
db "EXAMINE",$ff,$00
org $68B1
db "TAKE",$ff,$00
org $68C1
db "PRAISE",$ff,$00
org $68D1
db "TOUCH",$ff,$00
org $68E1
db "HIT",$ff,$00
org $68F1
db "1OPEN1CLOSE",$ff,$00
org $6901
db "CALL",$ff,$00
org $6911
db "WAIT",$ff,$00
org $6921
db "RUN",$ff,$00
org $6931
db "USE",$ff,$00
org $6941
db "GIVE",$ff,$00
org $6951
db "SHOW",$ff,$00
org $6961
db "DROP",$ff,$00
org $6971
db "YES",$ff,$00
org $6981
db "NO",$ff,$00
org $6991
db "MIHO",$ff,$00
org $69A1
db "MIZUHO",$ff,$00
org $69B1
db "D",$ff,$00
org $69C1
db "ERIKA",$ff,$00
org $69D1
db "LISTEN",$ff,$00
org $69E1
db "ITEMS",$ff,$00
org $69F1
db "PHOTO",$ff,$00
org $6A01
db "EMBRACE",$ff,$00
org $6A11
// Used when you confront Miho in front of the piano. Doesn't make sense to call her by her last name in English.
//db "TAKAYAMA",$ff,$00
db "MIZUHO",$ff,$00
org $6A21
db "MIZUHO",$ff,$00
org $6A31
db "MIHO",$ff,$00
org $6A41
db "HELP",$ff,$00
org $6A51
db "DON'T",$ff,$00
org $6A61
db "PEEK",$ff,$00
org $6A71
db "1MIHO?1",$ff,$00
org $6A81
db "1YOURSELF1",$ff,$00
org $6A91
db "BROTHER",$ff,$00
org $6AA1
db "CHARM",$ff,$00
org $6AB1
db "PHOTO",$ff,$00
org $6AC1
db "EAT",$ff,$00
org $6AD1
db "PLEAD",$ff,$00
org $6AE1
db "LEAVE",$ff,$00
org $6AF1
db "ORDER",$ff,$00
org $6B01
db "A",$ff,$00
org $6B11
db "B",$ff,$00
org $6B21
db "C",$ff,$00
org $6B31
db "D",$ff,$00
org $6B41
db "DRINK",$ff,$00
org $6B51
db "KISS",$ff,$00
org $6B61
db "HANDHOLD",$ff,$00

/////////////////////////////////////////////////////////////
// Other text
/////////////////////////////////////////////////////////////

//Points to text that has some spaces between
//apparently, the spaces store random RAM data.
//0x406E
//0x4078
//0x4085

//Last linebreak bank check bank: 6

//"pointer" @ 0x4DB4
org $4e34
db "    LOADING",$ff

//"Pointer" @ 0x5E7B

org $50B
db "SAVE",$ff

org $4e42
db "DISK SET      ERR.01",$ff
db "BATTERY       ERR.02",$ff
db "WRITE PROTECT ERR.03",$ff
db "GAME MAKER    ERR.04",$ff
db "GAME NAME     ERR.05",$ff
db "GAME VERSION  ERR.06",$ff
db "A,B SIDE      ERR.07",$ff
db "DISK NO.      ERR.08",$ff
db "DISK TROUBLE  ERR.00",$ff

//[IndexOfNextItem]ITEMNAME[Delimeter]Description[Delimeter]...

org $4e6
db "SWITCH DISK SIDE",$ff,$ff,$ff,$ff

table "asm/tbl/MenuFont.tbl"
org $35b3
db "DISK SET      ERR.01"
db "BATTERY       ERR.02"
db "WRITE PROTECT ERR.03"
db "GAME MAKER    ERR.04"
db "GAME NAME     ERR.05" //Maker name spelled wrong in orignal
db "GAME VERSION  ERR.06"
db "A.B SIDE      ERR.07"
db "DISK NO       ERR.08"
db "DISK TROUBLE  ERR.XX"
db "DISK FULL     ERR.30"
db "FILE CONTROL  ERR.31"

org $768; base $A719
//CALL THIS NUMBER.
CallNumberPPUTiles:
db $3B,$3C,$3D,$3D
db $3E
db $3F,$40,$41,$42
db $43

org $6414; base $89EC
LDA CallNumberPPUTiles,x
STA $2007
INX
CPX #$0a

/////////////////////////////////////////////////////////////
// Error Code Output Fix (For first error code table)
/////////////////////////////////////////////////////////////

define valueOfZeroCharacter	#$22

org $4eff; base $74D7
LDX {valueOfZeroCharacter}

org $4f0f; base $74E7
ADC {valueOfZeroCharacter}

org $4F1A; base $74F2
ADC {valueOfZeroCharacter}
