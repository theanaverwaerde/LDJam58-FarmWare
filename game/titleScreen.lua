local TitleScreen = Object.extend(Object)

function TitleScreen:new()
	love.mouse.setVisible(true)
end

function TitleScreen:update(dt)
	if love.mouse.isDown(1) then
		NextScene(true)
	end
end

function TitleScreen:draw()
	love.graphics.setBackgroundColor(1, 1, 1)

	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(love.graphics.newFont(24))
	love.graphics.print("Welcome to FarmWare!", 180, 200)
	love.graphics.print("Click to start!", 220, 300)
end

return TitleScreen
