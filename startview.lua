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

startView = View:extend {
    id = 'startview',
    
    onNew = function(self)
        self.city = TextInput:new{
            width = 300,
            height = 50,
            x = 50,
            y = 50
        }

        the.app:add(self.city)
    end,
    
    onUpdate = function(self, dt)
        if the.keys:justPressed('escape') then
            love.event.push("quit")
        end

        if the.keys:justPressed(' ') then
            the.app:changeState(the.app.STATE_PLAYING)
        end
    end,

    onDraw = function(self)
        local blink_factor = math.abs(math.sin(the.app.beat.timer_radians*2))
        local start = love.graphics.getHeight() * 0.8;

        love.graphics.setColor(255, 255, 255, blink_factor*200+55)
        love.graphics.printf("[SPACE] TO START", 0, start, love.graphics.getWidth(), "center")
        love.graphics.printf("[ESC] TO QUIT", 0, start + 40, love.graphics.getWidth(), "center")
        love.graphics.setColor(255, 255, 255, 255)
    end
}
