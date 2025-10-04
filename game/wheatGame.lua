local WheatGame = Object.extend(Object)

function WheatGame:new()
	love.mouse.setVisible(false)

	self.wheats = {}
	self.wheatImg = love.graphics.newImage("assets/wheat.png")
	self.scytheImg = love.graphics.newImage("assets/scythe.png")
	self.remainingWheats = 25

	for i=1,25 do
		self.wheats[i] = true
	end
end

function WheatGame:update(dt)
	if self.remainingWheats == 0 then
		print("You win!")
		love.window.setTitle("You win! Click to continue.")
		if love.mouse.isDown(1) then
			NextScene()
		end
	else
		love.window.setTitle("Wheats remaining: " .. self.remainingWheats)
		for i=1,#self.wheats do
			if self.wheats[i] then
				local row = math.floor((i-1)/5)
				local col = (i-1)%5
				local wheatX = col * 64 + 100
				local wheatY = row * 64 + 100
				local mouseX = love.mouse.getX()
				local mouseY = love.mouse.getY()
				if mouseX > wheatX and mouseX < wheatX + 64 and mouseY > wheatY and mouseY < wheatY + 64 then
					self.wheats[i] = false
					self.remainingWheats = self.remainingWheats - 1
				end
			end
		end
	end
end

function WheatGame:draw()
	love.graphics.setBackgroundColor(0.2, 0.7, 0.1)

	for i=1,#self.wheats do
		if self.wheats[i] then
			local row = math.floor((i-1)/5)
			local col = (i-1)%5
			love.graphics.draw(self.wheatImg, col * 64 + 100, row * 64 + 100)
		end
	end

	love.graphics.draw(self.scytheImg, love.mouse.getX(), love.mouse.getY())
end

return WheatGame
