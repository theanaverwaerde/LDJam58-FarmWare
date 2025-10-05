local ChickenGame = Object.extend(Object)

function ChickenGame:new()
	love.mouse.setVisible(true)

	self.chickens = {}
	self.fenceImg = love.graphics.newImage("assets/fence.png")
	self.chickenImg = love.graphics.newImage("assets/chicken.png")
	self.chickenHeight = self.chickenImg:getHeight()
	self.durationChickenMove = .5

	for i=1,4 do
		self.chickens[i] = {x = math.random(self.fenceImg:getWidth(), GameSize - self.chickenImg:getWidth()), lastMove = 0}
	end
end

function ChickenGame:update(dt)
	local allCaught = true
	for i=1,#self.chickens do
		if self.chickens[i].x + self.chickenImg:getWidth() > self.fenceImg:getWidth() then
			allCaught = false
			break
		end
	end
	if allCaught then
		print("You win!")
		love.window.setTitle("You win! Click to continue.")
		if love.mouse.isDown(1) then
			NextScene(true)
		end
		return
	end

	love.window.setTitle("Capture the chickens!")

	local mouseX = love.mouse.getX()
	local mouseY = love.mouse.getY()
	local movedChicken = false
	for i=1,#self.chickens do
		if self.chickens[i].lastMove > 0 then
			self.chickens[i].lastMove = self.chickens[i].lastMove - dt
			self.chickens[i].x = math.max(0, self.chickens[i].x - 200 * dt)
		end

		local x = self.chickens[i].x

		if love.mouse.isDown(1) and not movedChicken and
		   mouseY > GameSize - 100 - self.chickenHeight and mouseY < GameSize - 100 and
		   mouseX > x and mouseX < x + self.chickenImg:getWidth() then

			self.chickens[i].lastMove = self.durationChickenMove
			movedChicken = true
		end
	end
end

function ChickenGame:draw()
	love.graphics.setBackgroundColor(0.1, 0.7, 0.9)
	love.graphics.setColor(0.1, 0.9, 0.1)
	love.graphics.rectangle("fill", 0, GameSize - 100, GameSize, 100)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(self.fenceImg, 0, GameSize - 100 - self.fenceImg:getHeight())

	for i=1,#self.chickens do
		love.graphics.draw(self.chickenImg, self.chickens[i].x, GameSize - 100 - self.chickenImg:getHeight())
	end

end

return ChickenGame
