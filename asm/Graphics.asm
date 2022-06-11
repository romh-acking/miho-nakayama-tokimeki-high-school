arch nes.cpu

//Write new titlescreen
org $22df
incbin "asm/gfx/Titlescreen - rev4.chr"

//Write the new font
org $163
incbin "asm/gfx/Font 1.chr"
org $2e1f
incbin "asm/gfx/Font 2.chr"

org $7df0
incbin "asm/gfx/Cursors.chr"

org $1D5CD
incbin "asm/gfx/Push A.chr"