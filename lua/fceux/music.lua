while true do
gui.text(20, 20, "Instrument: ")
gui.text(20, 30, "Square 1: " .. string.format('%02x',memory.readbyte(0x60)))
gui.text(20, 40, "Square 2: " .. string.format('%02x',memory.readbyte(0x61)))
emu.frameadvance()
end