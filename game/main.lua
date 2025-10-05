Object = require "lib.classic"
GameSize = 600

local games  = {
	require "wheatGame",
	require "appleGame",
	require "chickenGame",
}

Scene = {}
-- CurrentGameIdx = math.random(1, #games)
CurrentGameIdx = 3

GameSpeed = 1
GameSpeedStep = .4

function love.load()
	Scene = games[CurrentGameIdx]()
end

function love.update(dt)
	Scene:update(dt * GameSpeed)
end

function love.draw()
	Scene:draw()
end

function NextScene(win)
	local newIdx
	repeat
		newIdx = math.random(1, #games)
	until newIdx ~= CurrentGameIdx

	CurrentGameIdx = newIdx

	if win then
		GameSpeed = GameSpeed + GameSpeedStep
	end

	Scene = games[CurrentGameIdx]()
end
