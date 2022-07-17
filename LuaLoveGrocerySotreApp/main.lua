print("main.lua")

--Font
local font = love.graphics.newFont("Assets/KenneyFont.ttf", 50)

local ButtonADD

local list = {}

--When love is loaded
function love.load()
	SuperLoad()
	print("love loaded!")
	--Getting images
	ButtonADD = love.graphics.newImage("Assets/ButtonADD.png")
	Background = love.graphics.newImage("Assets/Background.png")
	TextBox = love.graphics.newImage("Assets/TextBox.png")
end

local Btext = ""

--Drawing UI
function love.draw()

	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Background, 0, 68)

	love.graphics.draw(ButtonADD, 440, 1160)
	love.graphics.draw(TextBox, 10, 1170)	
	love.graphics.setBackgroundColor(250, 250, 255)
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(font)
	
	love.graphics.print("Matej's Shopping list", 50, 10)
	love.graphics.print(Btext, 20 , 1180)

	--Printing list
	local Y = 70
	for k,v in pairs(list) do
		love.graphics.print(v, 50 , Y)
		Y = Y + 54
	end
	
end

--Saves table to SaveFile.txt
function SuperSave(SuperTable)
	io.output("SaveFile.txt")
	for k,v in pairs(SuperTable) do
		io.write(v)
		io.write("\n")
	end
	io.close()
end

--Get files text in a line 
function fileLine (lineNum, fileName)
  local count = 0
  for line in io.lines(fileName) do
    count = count + 1
    if count == lineNum then return line end
  end
  error(fileName .. " has fewer than " .. lineNum .. " lines.")
end

--load table
function SuperLoad()

	SuperClearTable(list)
		
	local ctr = 0
	for _ in io.lines'SaveFile.txt' do
		ctr = ctr + 1
		table.insert(list, fileLine(ctr, "SaveFile.txt"))
	end
		
end

--Add Btext to table
function Add(T) 
	table.insert(list, T)
	Btext = ""
	SuperSave(list)
end

--Deletes all of table
function SuperClearTable(St)
	count = #St
	for i=0, count do St[i]=nil end
end

--Rounds X
function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

--Get mouse position
function love.mousepressed( x, y, button, istouch, presses)
	if button == 1 then
		if x > 450 and y > 1168 and y < 1250 and x < 700 then
			if Btext == "" then
				return
			else
				Add(Btext)
			end
		end

		table.remove(list, (round(y/54) - 1))
		SuperSave(list)
	end
end

--Get keypresses
function love.keypressed( key, scancode, isrepeat )	

	if key == "return" then
		if Btext == "" then
			return
		else
			Add(Btext)
			return
		end
	end
	
	if key == "backspace" then
		Btext = Btext:sub(1, -2)
	else
		if key == "space" then
			Btext = Btext .. " "
		else
			Btext = Btext .. key
		end
	end
end
