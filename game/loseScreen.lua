local LoseScreen = Object.extend(Object)

local timerDoorBase = .5
local waitCloseTime = .3

function LoseScreen:new()
	love.mouse.setVisible(true)

	self.doorImg = love.graphics.newImage("assets/door.png")
	self.winHeadImg = love.graphics.newImage("assets/win.png")
	self.loseHeadImg = love.graphics.newImage("assets/lose.png")
	self.bodyImg = love.graphics.newImage("assets/body.png")
	self.timer = 0
end

function LoseScreen:update(dt)
	self.timer = self.timer + dt

	if self.timer > timerDoorBase + waitCloseTime + timerDoorBase and love.mouse.isDown(1) then
		ResetGame()
	end
end

function LoseScreen:draw()
	love.graphics.setBackgroundColor(0, 0, 0)

	-- close with old scene
	if self.timer < timerDoorBase then
		local t = self.timer / timerDoorBase
		love.graphics.draw(self.doorImg, -300 + 300 * t)
		love.graphics.draw(self.doorImg, 900 - 300 * t, 0, 0, -1, 1)
		return
	-- keep close
	elseif self.timer < timerDoorBase + waitCloseTime then
		love.graphics.draw(self.doorImg, 0)
		love.graphics.draw(self.doorImg, 600, 0, 0, -1, 1)
		return
	end

	-- lose scene
	love.graphics.setBackgroundColor(1, 1, 1)
	love.graphics.rectangle("fill", 0, 0, 600, 600)

	love.graphics.draw(self.bodyImg, 136, 300)

	love.graphics.draw(self.loseHeadImg, 186, 200)

	-- text
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(love.graphics.newFont(54))
	love.graphics.print("Game Over", 150, 20)
	love.graphics.print("Level: " .. Stage, 200, 80)


	love.graphics.setFont(love.graphics.newFont(24))
	love.graphics.print("Click to restart!", 200, 160)

	love.graphics.setColor(1, 1, 1)

	if self.timer < timerDoorBase + waitCloseTime + timerDoorBase then
		local t = (self.timer - timerDoorBase - waitCloseTime) / timerDoorBase
		love.graphics.draw(self.doorImg, 0 - 300 * t)
		love.graphics.draw(self.doorImg, 600 + 300 * t, 0, 0, -1, 1)
	end
end

return LoseScreen
