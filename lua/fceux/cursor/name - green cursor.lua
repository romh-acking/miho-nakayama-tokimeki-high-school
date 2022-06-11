while true do
gui.text(20, 20, "Name Cursor: ")
gui.text(20, 30, "X: " .. string.format('%02x',memory.readbyte(0xC5)))
gui.text(20, 40, "Y: " .. string.format('%02x',memory.readbyte(0xC6)))
gui.text(20, 50, "Name X: " .. string.format('%02x',memory.readbyte(0xC7)))
emu.frameadvance()
end