while true do
gui.text(20, 20, "Disk Fax Cursor: ")
gui.text(20, 30, "X: " .. string.format('%02x',memory.readbyte(0x207)))
gui.text(20, 40, "Y: " .. string.format('%02x',memory.readbyte(0x204)))
emu.frameadvance()
end