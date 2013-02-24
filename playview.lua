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

require 'pointer'
require 'swarm'
require 'asteroid'

playView = View:new {
    id = 'playview',

    reset = function(self)
        if not self.swarm then
            self.swarm = swarm:new()
            the.app:add(self.swarm)
        else
            self.swarm:reset()
        end
        self.swarm:addMember(10)
        self.timer:every(1, function() self.swarm:addMember(1, 700, 450) end)

        self.timer:every(1, function() self:launchAsteroid() end)

        if self.pointer then
            self:remove(self.pointer)
        end
        self.pointer = pointer:new()
        the.app:add(self.pointer)
    end,

    launchAsteroid = function(self)
        local m = asteroid:new()
        the.app:add(m)
    end,

    onNew = function(self)
    end,
    
    onUpdate = function(self, dt)
        if the.keys:justPressed('escape') then
            the.app:changeState(the.app.STATE_PAUSED)
        end
    end,

    onDraw = function(self)
        love.graphics.setColor(255, 255, 255, 255)
    end
}
