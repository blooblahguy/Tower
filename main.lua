-- camera
require('lib.camera')

-- pathfinding
require('lib.jumper.grid')
require('lib.jumper.pathfinder')

require('game')

-- Runs first
function love.load()
	window = {}
	window.height = love.graphics.getHeight()
	window.width = love.graphics.getWidth()
end

-- Runs second
function love.update(dt) -- elapsed = time since last frame update
	require('lib.lurker').update() -- auto reloading files & debugging
	game:update(dt)
end

-- Runs third
function love.draw()
	game:draw()
end
-- Display happens