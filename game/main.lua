Object = require "lib.classic"
Scene = {}

local games  = {
	require "wheatGame",
}

function love.load()
	Scene = games[1]()
end

function love.update(dt)
	Scene:update(dt)
end

function love.draw()
	Scene:draw()
end

function NextScene()
	Scene = games[math.random(1, #games)]()
end
