while true do
gui.text(20, 20, "Disk Fax Cursor: ")
gui.text(20, 30, "X: " .. string.format('%02x',memory.readbyte(0xC5)))
gui.text(20, 40, "Y: " .. string.format('%02x',memory.readbyte(0xC6)))
emu.frameadvance()
end