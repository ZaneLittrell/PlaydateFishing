import "CoreLibs/sprites"

-- The full tag value
local FULL_TAG <const> = 0xFF
-- Tag for the fish moving in the positive x direction
local FISH_FORWARD_TAG <const> = 0x8

-- Fish update method
local function fishUpdate(leftBound, rightBound, speed)
    return function(self)
        if self.x > rightBound then
            -- Unset fish forward tag
            self:setTag(self:getTag() & (FULL_TAG ~ FISH_FORWARD_TAG))
        elseif self.x < leftBound then
            -- Set fish forward tag
            self:setTag(self:getTag() | FISH_FORWARD_TAG)
        end

        -- Check if the forward tag is set
        if (self:getTag() & FISH_FORWARD_TAG) ~= 0 then
            self:moveTo(self.x + (1 * speed), self.y)
        else
            self:moveTo(self.x - (1 * speed), self.y)
        end
    end
end

-- Create a fish sprite
local function fishSprite(fishImage, x, y, leftBound, rightBound, speed)
    local sprite = playdate.graphics.sprite.new(fishImage)
    sprite:moveTo(x, y)
    sprite.update = fishUpdate(leftBound, rightBound, speed)
    return sprite
end

return {
    fishSprite = fishSprite,
}
