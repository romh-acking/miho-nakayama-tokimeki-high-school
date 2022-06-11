while true do
gui.text(20, 20, "Dialogue ID #1: " .. string.format('%02d',memory.readbyte(0x6122)))
gui.text(20, 30, "Dialogue ID #2: " .. string.format('%02d',memory.readbyte(0x6123)))
gui.text(20, 40, "Dialogue ID #3: " .. string.format('%02d',memory.readbyte(0x6124)))
gui.text(20, 50, "Dialogue ID #4: " .. string.format('%02d',memory.readbyte(0x6125)))

emu.frameadvance()
end