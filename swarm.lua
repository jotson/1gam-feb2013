-- February2013
-- Copyright © 2013 John Watson <john@watson-net.com>

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

swarm = Sprite:extend{
    count = 10,
    members = {},
    width = 1,
    height = 1,

    onNew = function(self)
        self:reset()
    end,

    onUpdate = function(self)
        self.x = love.mouse.getX()
        self.y = love.mouse.getY()
    end,

    reset = function(self)
        for i = #self.members,1,-1 do
            the.app:remove(self.members[i])
            self.members[i]:die()
            table.remove(self.members, i)
        end
        for i = 1, self.count do
            local m = swarm_member:new()
            m:init(self)
            table.insert(self.members, m)
        end
    end,
}

swarm_member = Sprite:extend{
    ACCELERATION = 100,
    MAX_SPEED = 150,
    MIN_DISTANCE = 10,
    width = 10,
    height = 10,

    init = function(self, swarm)
        self.swarm = swarm
        self.x = math.random(love.graphics.getWidth())
        self.y = math.random(love.graphics.getHeight())
        self.minVelocity = { x = -self.MAX_SPEED, y = -self.MAX_SPEED }
        self.maxVelocity = { x = self.MAX_SPEED, y = self.MAX_SPEED }
        -- self.drag = { x = self.MAX_SPEED/5, y = self.MAX_SPEED/5 }
    end,

    onNew = function(self, swarm)
        the.app:add(self)
    end,

    onUpdate = function(self, dt)
        -- Move towards swarm center
        local othervector = vector(self.swarm.x, self.swarm.y)
        local myvector = vector(self.x, self.y)
        local dir = (othervector - myvector):normalized()
        local dist = myvector:dist(othervector)
        local accel = 1/dist/love.graphics.getWidth() * self.ACCELERATION/2 + self.ACCELERATION/2
        self.acceleration = { x = dir.x * accel, y = dir.y * accel }

        -- Braking
        if (dist < 100) then
            local r = dist/100
            self.minVelocity = { x = -self.MAX_SPEED*r, y = -self.MAX_SPEED*r }
            self.maxVelocity = { x = self.MAX_SPEED*r, y = self.MAX_SPEED*r }
        end

        -- Collision detection to keep minimum distance from other members
    end,

    onDraw = function(self)
        -- TODO: Replace with animated sprite
        love.graphics.push()
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", self.x, self.y, self.width)
        love.graphics.pop()
    end,
}
