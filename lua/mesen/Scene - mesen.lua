function sceneInfo()
  state = emu.getState()

  --Draw some rectangles and print some text
  emu.drawRectangle(8, 8, 120, 40, 0x302060FF, true, 1)
  emu.drawRectangle(8, 8, 120, 40, 0x30FF4040, false, 1)
  emu.drawString(12, 12, "Dialogue ID #1: " ..  string.format('%02d', emu.read(0x6122, emu.memType.cpu)), 0xFFFFFF, 0xFF000000, 5)
  emu.drawString(12, 20, "Dialogue ID #2: " ..  string.format('%02d', emu.read(0x6123, emu.memType.cpu)), 0xFFFFFF, 0xFF000000, 5)
  emu.drawString(12, 28, "Dialogue ID #3: " ..  string.format('%02d', emu.read(0x6124, emu.memType.cpu)), 0xFFFFFF, 0xFF000000, 5)
  emu.drawString(12, 36, "Dialogue ID #4: " ..  string.format('%02d', emu.read(0x6125, emu.memType.cpu)), 0xFFFFFF, 0xFF000000, 5)

  
end

emu.addEventCallback(sceneInfo, emu.eventType.endFrame)
