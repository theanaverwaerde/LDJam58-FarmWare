local TitleScreen = Object.extend(Object)

local timerDoorBase = .5
local waitCloseTime = .3
local openTime = .8

function TitleScreen:new()
	self.doorImg = love.graphics.newImage("assets/door.png")
	self.winHeadImg = love.graphics.newImage("assets/win.png")
	self.loseHeadImg = love.graphics.newImage("assets/lose.png")
	self.bodyImg = love.graphics.newImage("assets/body.png")
	self.lifeImg = love.graphics.newImage("assets/on.png")
	self.noLifeImg = love.graphics.newImage("assets/off.png")

	self.show = false
	self.timer = 0
end

function TitleScreen:update(dt)
	if not self.show then
		return
	end

	self.timer = self.timer + dt


	if self.timer > timerDoorBase + waitCloseTime + timerDoorBase and
	   self.timer < timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase then
		love.mouse.setVisible(true)
	end

	if self.waitingForNext and self.timer > timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase then
		self.waitingForNext = false
		ApplyNextScene()
		return
	end

	if self.timer > timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase + waitCloseTime + timerDoorBase then
		Playing = true
		self.show = false
		return
	end
end

-- close door in .2s
-- wait .5s with door closed
-- open door in .2s
-- show collector with life and stage count 2s
-- close door in .2s
-- call ApplyNextScene()
-- wait .5s with door closed
-- open door in .2s

function TitleScreen:draw()
	if not self.show then
		return
	end
	love.graphics.setColor(1, 1, 1)

	-- close with old scene
	if self.timer < timerDoorBase then
		local t = self.timer / timerDoorBase
		love.graphics.draw(self.doorImg, -300 + 300 * t)
		love.graphics.draw(self.doorImg, 900 - 300 * t, 0, 0, -1, 1)
		return
	-- keep close
	elseif self.timer < timerDoorBase + waitCloseTime or
	(self.timer > timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase and 
	self.timer < timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase + waitCloseTime) then
		love.graphics.draw(self.doorImg, 0)
		love.graphics.draw(self.doorImg, 600, 0, 0, -1, 1)
		return
	-- open with new scene
	elseif self.timer > timerDoorBase + waitCloseTime + timerDoorBase + openTime + timerDoorBase + waitCloseTime then
		local t = (self.timer - timerDoorBase - waitCloseTime - timerDoorBase - openTime - timerDoorBase - waitCloseTime) / timerDoorBase
		love.graphics.draw(self.doorImg, 0 - 300 * t)
		love.graphics.draw(self.doorImg, 600 + 300 * t, 0, 0, -1, 1)
		return
	end
	-- transition scene
	love.graphics.setBackgroundColor(1, 1, 1)
	love.graphics.rectangle("fill", 0, 0, 600, 600)

	love.graphics.draw(self.bodyImg, 136, 300)
	local head
	if self.happy then
		head = self.winHeadImg
	else
		head = self.loseHeadImg
	end

	love.graphics.draw(head, 186, 200)

	for i=1,3 do
		local img
		if i <= Life then
			img = self.lifeImg
		else
			img = self.noLifeImg
		end
		love.graphics.draw(img, 100 + (i-1) * 130, 20)
	end

	-- text
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(love.graphics.newFont(54))
	love.graphics.print("Level: " .. Stage, 200, 140)
	love.graphics.setColor(1, 1, 1)

	
	-- opening for transition screen
	if self.timer < timerDoorBase + waitCloseTime + timerDoorBase then
		local t = (self.timer - timerDoorBase - waitCloseTime) / timerDoorBase
		love.graphics.draw(self.doorImg, 0 - 300 * t)
		love.graphics.draw(self.doorImg, 600 + 300 * t, 0, 0, -1, 1)
	-- closing for transition screen
	elseif self.timer > timerDoorBase + waitCloseTime + timerDoorBase + openTime then
		local t = (self.timer - timerDoorBase - waitCloseTime - timerDoorBase - openTime) / timerDoorBase
		love.graphics.draw(self.doorImg, -300 + 300 * t)
		love.graphics.draw(self.doorImg, 900 - 300 * t, 0, 0, -1, 1)
	end

end

function TitleScreen:trigger(win)
	Playing = false
	self.show = true
	self.happy = win
	self.timer = 0
	self.waitingForNext = true
end

return TitleScreen
