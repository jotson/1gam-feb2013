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

DEBUG = true
STRICT = true

require 'zoetrope'
require 'startview'
require 'playview'
require 'pauseview'
require 'gameoverview'

the.app = App:new{
    STATE_START = 1,
    STATE_PLAYING = 2,
    STATE_PAUSED = 3,
    STATE_GAMEOVER = 4,

    name = "GAME",

    onRun = function(self)
        -- Load audio, font, graphics

        love.mouse.setVisible(false)

        self:changeState(self.STATE_START)
    end,

    changeState = function(self, state)
        if state == self.STATE_START then
            self.view = startView
            self.view:reset()
        end

        if state == self.STATE_PAUSED then
            self.view = pauseView
            self.view:reset()
        end

        if state == self.STATE_PLAYING then
            self.view = playView
            if self.state == self.STATE_START then
                self.view:reset()
            end
        end

        if state == self.STATE_GAMEOVER then
            self.view = gameoverView
            self.view:reset()
        end

        self.state = state
    end,

    onUpdate = function(self, dt)
    end,
}

function formatNumber(n)
    local retval = ""
    for i = 1,string.len(n) do
        retval = string.sub(n, -i, -i) .. retval
        if i % 3 == 0 and i < string.len(n) then
            retval = ',' .. retval
        end
    end
    return retval
end