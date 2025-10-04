Wheats = {}
WheatImg = love.graphics.newImage("assets/wheat.png")
ScytheImg = love.graphics.newImage("assets/scythe.png")
RemainingWheats = 25

function love.load()
	love.mouse.setVisible(false)
	resetGame()
end

function love.update(dt)
	if RemainingWheats == 0 then
		print("You win!")
		if love.keyboard.isDown("r") then
			resetGame()
		end
		love.window.setTitle("You win! Press R to reset.")
	else
		love.window.setTitle("Wheats remaining: " .. RemainingWheats)
		for i=1,25 do
			if Wheats[i] then
				local row = math.floor((i-1)/5)
				local col = (i-1)%5
				local wheatX = col * 64 + 100
				local wheatY = row * 64 + 100
				local mouseX = love.mouse.getX()
				local mouseY = love.mouse.getY()
				if mouseX > wheatX and mouseX < wheatX + 64 and mouseY > wheatY and mouseY < wheatY + 64 then
					Wheats[i] = false
					RemainingWheats = RemainingWheats - 1
				end
			end
		end
	end
end

function resetGame()
	Wheats = {}
	for i=1,25 do
		Wheats[i] = true
	end
	RemainingWheats = 25
end

function love.draw()
	love.graphics.setBackgroundColor(0.2, 0.7, 0.1)

	for i=1,25 do
		if Wheats[i] then
			local row = math.floor((i-1)/5)
			local col = (i-1)%5
			love.graphics.draw(WheatImg, col * 64 + 100, row * 64 + 100)
		end
	end

	love.graphics.draw(ScytheImg, love.mouse.getX(), love.mouse.getY())
end
