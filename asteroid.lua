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

asteroid = Sprite:extend{
    MAX_VELOCITY_X = 30,
    MAX_VELOCITY_Y = 100,

    BIG_ROCK = 25,
    DAMAGE = 5,

    id = 'asteroid',
    width = 5,
    height = 5,
    alpha = 255,
    scale = 1,
    solid = true,

    onNew = function(self)
        self.y = -10
        self.x = math.random(love.graphics.getWidth())
        self.size = 5
        if math.random(100) > 95 then
            self.size = self.BIG_ROCK
        end
        self.width = self.size
        self.height = self.size
        self.velocity = {
            x = math.random() * self.MAX_VELOCITY_X - self.MAX_VELOCITY_X/2,
            y = math.random() * self.MAX_VELOCITY_Y + 10,
            rotation = math.random() * 20 - 10
        }
        if self.size == self.BIG_ROCK then
            self.velocity.x = self.velocity.x * 0.25
            self.velocity.rotation = self.velocity.rotation * 0.25
        end
    end,

    onUpdate = function(self, dt)
    end,

    onDraw = function(self)
        love.graphics.push()

        love.graphics.setColor(200, 0, 0, self.alpha)

        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.rotation)
        love.graphics.circle('fill', 0, 0, self.size * self.scale, 5)

        love.graphics.setColor(255, 255, 255, 255)

        love.graphics.pop()
    end,

    onCollide = function(self, other, x_overlap, y_overlap)
        if other.id == 'swarm_member' then
            self.size = self.size - self.DAMAGE
            self.width = self.size
            self.height = self.size
            if self.size <= 1 then
                self:explode()
            end
        end
    end,

    explode = function(self)
        -- TODO Explosion
        self:die()
        the.app:remove(self)
    end,
}
