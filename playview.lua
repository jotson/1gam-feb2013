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
require 'building'

GROUND_HEIGHT = 500

playView = View:extend {
    id = 'playview',
    gametime = 0,
    ending = false,

    init = function(self)
        -- Sky
        the.app:add(
            Fill:new{
                id = 'sky',
                width = love.graphics.getWidth(),
                height = love.graphics.getHeight(),
                fill = {50, 150, 255},
                solid = false,
            }
        )

        -- Build city
        for i = 1, math.ceil(love.graphics.getWidth()/building.width) do
            local b = building:new({ x = building.width * (i-1) })
            the.app:add(b)
        end

        -- Create swarm
        self.swarm = swarm:new()
        the.app:add(self.swarm)
        self.swarm:addMember(10)

        -- Add pointer
        self.pointer = pointer:new()
        the.app:add(self.pointer)

        -- Setup timers
        -- Stop running timers so they don't accumulate
        self.timer:stop()
        self.timer:every(1/the.app.beat.beats_per_second, function() self.swarm:addMember(1, love.graphics.getWidth()/2, GROUND_HEIGHT) end)
        self.timer:every(1/the.app.beat.beats_per_second, function() self:launchAsteroid() end)
    end,

    launchAsteroid = function(self)
        local r = math.random(1000)
        local size = asteroid.MIN_SIZE

        local difficulty = self.gametime/1
        if r > 990 - difficulty then
            size = asteroid.BIG_ROCK
        end
        if r > 1000 - difficulty then
            size = asteroid.GIANT_ROCK
        end
        -- if self.gametime > 5 then
        --     size = asteroid.EXTINCTION_ROCK
        --     self.timer:stop()
        -- end
        local m = asteroid:new({ size = size })
        the.app:add(m)
    end,

    onNew = function(self)
    end,
    
    onUpdate = function(self, dt)
        if the.keys:justPressed('escape') then
            the.app:changeState(the.app.STATE_PAUSED)
        end

        -- Game over condition
        if not self.ending then
            local buildings = 0
            for i, s in ipairs(self.sprites) do
                if s.id and s.id == 'building' and s.hp > 0 then
                    buildings = buildings + 1
                end
            end
            if buildings <= 0 then
                self.ending = true
                self:fade({ 255, 255, 255 }, 5)
                    :andThen(function() the.app:changeState(the.app.STATE_GAMEOVER) end)
            end
        end

        self.gametime = self.gametime + dt
    end,

    onDraw = function(self)
        love.graphics.setColor(255, 255, 255, 255)
    end
}
