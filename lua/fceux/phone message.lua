function lshift(x, by)
  return x * 2 ^ by
end

local showMessage
local val
showMessage = false
while true do
	if memory.getregister("pc") > 0x6C7E and memory.getregister("pc") < 0x6Cd0
	then
		showMessage = true
		val = lshift(memory.readbyte(0x1), 8) + memory.readbyte(0x0) 
	end
	
	if memory.readbyte(0x81a) == 0x40
	then
		showMessage = false
		val = 0
	end

	if showMessage == true
	then 
		local conv = "N/A"
		
		-- RAM addresses
		
		--03-540-0000
		if val == 0x6A51 or val == 0x6ABF
		then
			conv = "Miho: Hello, Miho here. How are you all\ndoing? I'm in the middle of my tour of\nJapan. I'm trying my best every single\nday. I get pretty nervous before going\nonstage, but I have a friend who always\ncheers me up. It's my cute little bunny\ncharm. With him at my side, I can always\nsing for you. With that said, please come\nsee me!<3"
		--045-952-0010
		--045-833-9000
		elseif val == 0x6A67 or val == 0x6AD5
		then
			conv = "Mizuho: I wanted to thank you. I was\nin a hurry at the time, so I didn't\nget a chance to thank you properly.\nYou see, that bunny charm means a lot\nto me. So, thank you very much!\nI hope we have more time to talk\nnext time we meet!<3"
		--06-700-2000
		--06-700-1000
		elseif val == 0x6A5c or val == 0x6ACA
		then
			conv = "Brother: Know where I'm calling from? I'm\nin the green room of Miho Nakayama's concert!\nI'm doing her photo book, so I'm interviewing\nher too. Wanna hear a small excerpt?\n\nMiho: ...Something that made me happy recently?\nHmmm... I guess... when someone returned my\nbunny charm. I thought I'd lost him forever..."
		--06-790-1099
		--06-790-1313
		elseif val == 0x6aa9 or val == 0x6B17
		then
			conv = "Miho: You may not have realized it,\nbut... I already know. You're going out\nwith Shimizu, aren't you? I must say, I'm\ndisappointed. ...I was a fool to fall for\nyour sweet words. I hate you!"
		--045-583-7000
		--045-784-5311
		elseif val == 0x6a72 or val == 0x6ae0
		then
			conv = "Miho: Thank you so much for today. I had\na lot of fun. The truth is... I'm really\nnervous right now. I think I'm being stalked\nby someone. They were following us today too!\nI'm not even worried about my privacy.\nI'm just afraid that I'll be forced to change\nschools again... Anyway! I wanted to go watch\na movie with you next Sunday.\nIt's called 'Stand By Miho'. I've always wanted\nto watch it from the perspective of the\naudience!"
		--011-512-4000
		--011-611-9600
		elseif val == 0x6a7d or val == 0x6aeb
		then
			conv = "Manager: You're a \"friend\", you say?\nSure thing, bud! Now quit bothering her!\n\n(Then, Miho snatches the receiver)\n\nMiho: Sorry about that. Thank you for\nthe present! I've wanted this for so\nlong! I also have a present for you.\nI hid the key to my locker inside the\npiano in the music room. My present is\ninside a blue paper bag!<3"
		--011-711-4000
		--011-222-6600
		elseif val == 0x6a88 or val == 0x6AF6
		then
			conv = "Miho: Sorry for all the trouble...\nI have to make this quick, so listen:\nwait for me at the usual coffee shop on\nChristmas Eve.\n\n(The nasty manager picks up the phone\nonce again)\n\nManager: It's you, isn't it? That guy\nwho keeps stalking Miho. I won't ask a\nsecond time: don't show yourself in front\nof her ever again!"
		--092-475-7878
		--092-781-9900
		elseif val == 0x6a93 or val == 0x6b01
		then
			conv = "Miho: I've been thinking about it ever\nsince. In the end, I realized that...\nI can't stop singing. It's been my dream\nsince I was a little girl... I guess living\na school life like a normal girl was too\nmuch to ask. Thank you for the wonderful\nmemories. I hope we can be best friends\nforever."
		--092-522-4900
		--092-585-3001
		elseif val == 0x6a9e or val == 0x6b0c
		then
			conv = "Miho: I love you. I really do. But I don't\nwant to cause you trouble or to everyone else\nat school. So, I've decided... As sad as it is,\nI'll be changing schools again. Tomorrow will\nbe my final day at school. Please, come to the\nrooftop after classes. I must see you."
		end
		
		gui.text(20, 70, conv)
	end

	emu.frameadvance()
end
