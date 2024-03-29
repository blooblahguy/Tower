camera = {}
camera.x = 0
camera.y = 0
camera.scale = 1
camera.rotation = 0
camera.dragging = false
camera.dragging_x = 0
camera.dragging_y = 0

function camera:set()
	if (self.dragging) then
		--print(love.mouse.getPosition())
		local mx, my = love.mouse.getPosition()

		self.x = self.x + (camera.dragging_x - mx)
		self.y = self.y + (camera.dragging_y - my)
		camera.dragging_x = mx
		camera.dragging_y = my
		--camera:setPosition(love.mouse.getPosition())
	end

	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.translate(-self.x, -self.y)
	love.graphics.scale(1 / self.scale)
end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:zoom(sx)
	-- if zooming in, zoon towards mouse
	if (sx < 0) then
		local x, y = love.mouse.getPosition()

		local x_mid = love.graphics.getWidth() * 0.5
		local y_mid = love.graphics.getHeight() * 0.5

		local x_offs = (x - x_mid) * (1 / self.scale) 
		local y_offs = (y - y_mid) * (1 / self.scale) 

		camera:move(x_offs, y_offs)
	else
		local x_mid = love.graphics.getWidth() * 0.5
		local y_mid = love.graphics.getHeight() * 0.5

		local x_offs = self.x + x_mid 
		local y_offs = self.y + y_mid 
		--camera:move(x_offs, y_offs)
	end

	-- set our scale
	self.scale = self.scale + (sx * self.scale)
	-- zoom towards mouse

	
	
	
	
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera:setScale(s)
	self.scale = sx or self.scale
end

-- mouse controls
function love.wheelmoved(x, y)
    if y > 0 then
        camera:zoom(-.1)
    elseif y < 0 then
        camera:zoom(.1)
    end
end

function love.mousereleased(x, y, button)
	if button == 2 then
		camera.dragging_x = 0
		camera.dragging_y = 0
		camera.dragging = false
	end
end
function love.mousepressed(x, y, button)
	if button == 2 then
		camera.dragging_x = x
		camera.dragging_y = y
		camera.dragging = true
	end
end