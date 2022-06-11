arch nes.cpu

//Weird discovery, but you can control where the 
//gender characters are written at 0x305c (ROM)

/////////////////////////////////////////////////////////////
// Gender Symbols Encoding
/////////////////////////////////////////////////////////////

//Change the palette of the gender symbols
//The game stores these as 1BPP but changes the encoding 
//to change the palettes. 
//Kind of crazy they'd save space for some font graphics.
//Data for where the gender symbols are on the disk
//and where to write them to the PPU are closeby.
org $305c
db $82

/////////////////////////////////////////////////////////////
// Welcome Screen - font
/////////////////////////////////////////////////////////////
//Apparently this screen doesn't want to work 
//with the font below it.
//So we'll just change where the font is loaded.

org $3027
db $dc,$a2

/////////////////////////////////////////////////////////////
// Welcome Screen - menu options
/////////////////////////////////////////////////////////////
org $3263
db "FORM     ",$F1,$23,$0F
db "MESSAGE"

/////////////////////////////////////////////////////////////
// Name screen
/////////////////////////////////////////////////////////////

table "asm/tbl/MenuFont.tbl"
org $3292
db " WHO ARE YOU? "

org $32A4
db "A B C D E  F G H I J"
org $32C9
db "K L M N O  P Q R S T"
org $32EE
db "U V W X Y  Z # # # #"
org $3313
db "1 2 3 4 5  6 7 8 9 0"
org $3338
db "! ? # # #  # # # # #"
org $335D
db "# # # # #  # # # # #"
org $3375
db "# # # # #  # # # # #"
org $338D
db "# # # # #  # # # END"

org $32BC
db "         "
org $32E1
db "         "
org $3306
db "         "
org $332B
db "         "
org $3350
db "         "

org $4fb
db "LOADING",$ff

org $35a3
db "LOADING",$ff

/////////////////////////////////////////////////////////////
//Corect titlescreen palette
/////////////////////////////////////////////////////////////

//Format
//8Z XX = print pal hex XX++ repeating Z times
//XX    = print pal hex XX   once


org $317b
db $85,$05
db $8b,$00
db $81,$00 //waste two bytes


/////////////////////////////////////////////////////////////
// Titlescreen graphics
/////////////////////////////////////////////////////////////

//Format
//BZ XX = print tile ID XX   		repeating Z times
//DZ XX = print tile ID XX++ 		repeating Z times
//E0 XX = print tile ID #$10 + XX++ repeating Z times
//XX    = print tile ID XX   		once

org $30c5

//old
//db $B2,$01 //blank margin (2 tiles)
//db $DA,$50 //top part of title (A tiles)
db $BC,$01 //blank margin (2 tiles) //new

db $BD,$01 //blank paper (D tiles)
db $B6,$00 //Black tiles 

//------------------------------------------
// New Line
//------------------------------------------

db $02 //note hole

//old
//db $B2,$01 //blank paper
//db $DA,$60 //bottom part of title (A tiles)
//db $BD,$01 //blank paper (D tiles)

db $B2,$01 //blank paper
db $D5,$50 //top part of title (A tiles)
db $DA,$60 //bottom part of title (A tiles)
db $B8,$01


db $B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02 //note hole


db $BC,$01,$BD,$01,$B6,$00

//------------------------------------------
// New Line (top of green text)
//------------------------------------------

db $02
db $B5,$01
db $DC,$04
db $D4,$4A
db $B4,$01
db $B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02
db $01,$01
db $df,$11
db $D6,$5A
db $B2,$01
db $B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02
db $01,$01
db $df,$21
db $D6,$6A
db $B2,$01
db $B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02,$B2,$01,$DF,$31,$D6,$7A,$B2,$01,$B6,$00

//------------------------------------------
// New Line (last line of green text)
//------------------------------------------

db $02
db $B3,$01
db $D4,$42
db $30
db $01
db $Ba,$01
db $D4,$8C
db $B2,$01
db $B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02
db $B3,$01
db $20
db $10
db $C0,$01
db $D2,$48,$B2,$01,$B6,$00

//------------------------------------------
// New Line
//------------------------------------------

db $02,$C6,$01,$D2,$77,$01,$B6,$00,$02,$C6,$01,$79,$D2,$90,$B6,$00,$02,$B7,$01,$D2,$70,$73,$72,$01,$D4,$73,$74,$B6,$01,$D3,$92,$B5,$00,$02,$C8,$01,$92,$8B,$B5,$00,$02,$C9,$01,$B6,$00,$02,$C9,$01,$B6,$00,$02,$C9,$01,$B6,$00,$02,$B6,$01,$D5,$80,$01,$D6,$85,$B7,$01,$B6,$00,$02,$C9,$01,$B0,$83,$00

db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

/////////////////////////////////////////////////////////////
// Disk fax (Tiles)
/////////////////////////////////////////////////////////////

// 00:BA67:A0 50     LDY #$50
// 00:BA69:A2 60     LDX #$60
org $1ab6
ldy #$60
ldx #$20

//pallette
org $3704
db $0f,$0f //db $10,$14

org $3706
db $0F,$10,$1d //db $33,$1a,$1d

org $370e
db $0f,$0f,$0f,$0f

table "asm/tbl/DiskFax.tbl"

org $33ae
//なまえ　とうろく
db "  FORM  "
//db $80,$20,$C4,$04,$0F ORIGINAL
//$04 = length of following word
db $80,$20,$C4,$05,$0F
db "NAME"

//db $80,$20,LOCATION,$8-amount,$0E
db $80,$20,$EB,$8C,$0E
db $80,$21,$04,$04,$0F

db "AGE"

//adding 1 moves it over by one
//db $87,$20,$05,$0F

db $86,$20,$07,$0F


db "GENDER"

db $80,$21,$2B,$82,$0E

db $89,$20,$01,$0E

db $80,$21,$44,$11,$0F

db "ADDRESS         "

db $80,$21,$A4,$98,$0E
db $80,$21,$E4,$98,$0E
db $80,$22,$04,$06,$0F

db "PHONE"

db $80,$22,$2B,$8C,$0E,$80,$22,$44,$01,$06,$96,$07,$01,$08,$80,$22,$64,$01,$0C,$80,$22,$7B,$01,$0D,$80,$22,$84,$01,$0C,$80,$22,$9B,$01,$0D,$80,$22,$A4,$01,$0C,$80,$22,$BB,$01,$0D,$80,$22,$C4,$01,$0C,$80,$22,$DB,$01,$0D,$80,$22,$E4,$01,$0C,$80,$22,$FB,$01,$0D,$80,$23,$04,$01,$0C,$80,$23,$1B,$01,$0D,$80,$23,$24,$01,$09,$96,$0A,$01,$0B,$80,$23,$C0




//------------------------------------------
// PPU attribute tables data
//------------------------------------------

//8Z XX = print pal hex XX++ repeating Z times
//XX    = print pal hex XX   once

db $89,$00
db $02
db $55
db $15
db $82,$05
db $84,$00
db $05
db $55
db $51
db $04
db $05
db $01
db $8B
db $00
db $01
db $A5 //Phone
db $81,$a1
db $86,$A0
db $84,$AA
db $02
db $EA
db $BA
db $82,$00
db $86,$0A
db $89,$00

//------------------------------------------
// Character selection
//------------------------------------------

db $00,$22,$65,$16
db "ABCDEFGHI    1234   %^"
db $80,$22,$85,$16
db "JKLMNOPQR    5678   .,"
db $80,$22,$A5,$16
db "STUVWXYZ     90     - "
db $80,$22,$C5,$16
db "                      "
db $80,$22,$E5,$16
db "                      "
db $80,$23,$05,$16
db "                  SAVE"
db $00,$22

//------------------------------------------
// Saving sanity check failure message
//------------------------------------------

//thanks to Pluvius and uwabami for this translation
org $3520
db "Can't update data."
