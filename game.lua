game = {}
game.time = 7
game.sunrise = 6
game.sunset = 20

game.grid_size = 20
game.size = {x=200, y=400}
game.dimensions = {x = game.size.x * game.grid_size, y = game.size.y * game.grid_size}

game.moonrise = 18
game.moonset = 6

function CreateObject()
	local object = {}

	object.x = 0
	object.y = 0
	object.size = 0
	object.width = 0
	object.height = 0

	return object
end
function game:update(dt)
	sky = sky or CreateObject()
	sky.color = {0, 255 * 0.6, 255 *.9, 255}

	moon = moon or CreateObject()
	moon.size = 30

	sun = sun or CreateObject()
	sun.size = 30

    centerX = game.dimensions.x * 0.5
    bottomY = game.dimensions.y
    radiusX = game.dimensions.x * .7
    radiusY = game.dimensions.y * 0.3

	game.time = game.time + dt
	if (game.time > 24) then game.time = 0 end -- 24 hour cycle

	local sunTime = (game.time - game.sunrise) / (game.sunset - game.sunrise);  
	local angle = math.pi + math.pi * sunTime
	sun.x = centerX + radiusX * math.cos(angle);
	sun.y = bottomY + radiusY * math.sin(angle);

	local moonTime = (game.moonrise - game.time) / (game.moonset - game.moonrise );  
	local angle = math.pi + math.pi * moonTime
	moon.x = centerX + radiusX * math.cos(angle);
	moon.y = bottomY + radiusY * math.sin(angle);

	--------------------
	-- sky coloring
	--------------------
	sky.sunrise = sky.sunrise or CreateObject()

	
end

function game:draw()
	camera:set()

	-- sky
	love.graphics.setColor(unpack(sky.color))
    love.graphics.rectangle("fill", 0, 0, game.dimensions.x, game.dimensions.y)

	-- sun
	love.graphics.setColor(255, 255, 19, 255)
	love.graphics.circle("fill", sun.x, sun.y, sun.size)

	-- moon
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle("fill", moon.x, moon.y, moon.size)

	-- ground
	love.graphics.setColor(139, 69, 19, 255)
    love.graphics.rectangle("fill", 0, game.dimensions.y - (game.grid_size * 20), game.dimensions.x, game.grid_size * 20)

	--[[for angle = 0, math.pi * 2, 0.1 do
		local x = centerX + radiusX * math.cos(angle);
		local y = bottomY + radiusY * math.sin(angle);
		love.graphics.rectangle("fill", x-2, y-2, 40, 40)
	end--]]
	


	camera:unset()
end

return game