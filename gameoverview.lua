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

gameoverView = View:extend {
    id = 'gameoverview',
    
    onUpdate = function(self, dt)
        if the.keys:justPressed(' ') then
            the.app:changeState(the.app.STATE_START)
        end
    end,

    onDraw = function(self)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('GAME OVER', 0, love.graphics.getHeight()/2-20, love.graphics.getWidth(), 'center')
        
        love.graphics.setColor(255, 255, 255, 255)
    end
}
