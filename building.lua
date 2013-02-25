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

building_img = {
    'img/apartment01.png',
    'img/apartment02.png',
    'img/apartment03.png',
    'img/apartment04.png',
    'img/club01.png',
    'img/park01.png',
    'img/policestation01.png',
    'img/restaurant01.png',
}

road_img = {
    'img/verticalroad01.png',
    'img/verticalroad01b.png',
    'img/verticalroad01c.png',
    'img/verticalroad01d.png'
}

building = Animation:extend{
    id = 'building',
    
    width = 100,
    height = 175,
    solid = false,
    sequences = { default = { frames = { 1 }, fps = 1 } },

    onNew = function(self)
        self.image = building_img[math.random(#building_img)]
        self.y = love.graphics.getHeight() - self.height
    end,

    onUpdate = function(self, dt)
    end,

    onDraw = function(self)
        love.graphics.setColor(255,255,255,255)
    end,
}