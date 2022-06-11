while true do
gui.text(20, 20, "Menu Cursor: ")
gui.text(20, 30, "X: " .. string.format('%02x',memory.readbyte(0x20B)))
gui.text(20, 40, "Y: " .. string.format('%02x',memory.readbyte(0x208)))
gui.text(20, 50, "Menu option #: " .. string.format('%02x',memory.readbyte(0xb1ae)))
emu.frameadvance()
end