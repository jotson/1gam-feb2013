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

    onNew = function(self)
        for i = 1, self.count do
            local m = swarm_member:new()
            m:init(self)
            table.insert(self.members, m)
        end
        the.view:add(self)
    end,

    onUpdate = function(self)
        -- TODO Calculate center of swarm
        
        -- PLACEHOLDER:
        self.x = love.mouse.getX()
        self.y = love.mouse.getY()
    end,
}

swarm_member = Sprite:extend{
    init = function(self, swarm)
        self.swarm = swarm
        self.x = swarm.x + math.random(100) - 50
        self.y = swarm.y + math.random(100) - 50
    end,

    onNew = function(self, swarm)
        the.view:add(self)
    end,

    onUpdate = function(self, dt)
        -- TODO Swarming behavior
        -- TODO Go towards swarm center
        -- TODO Keep minimum distance from other members

        -- PLACEHOLDER:
        self.x = self.swarm.x + math.random(100) - 50
        self.y = self.swarm.y + math.random(100) - 50
    end,

    onDraw = function(self)
        -- TODO: Replace with animated sprite
        love.graphics.push()
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", self.x, self.y, 10)
        love.graphics.pop()
    end,
}
