import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Tag for the background sprite
local BACKGROUND_TAG <const> = 0xFF
-- Length of each frame in milliseconds
local WAVE_SPEED <const> = 600
-- Wave animation timer
local waveAnim = nil
-- Current slide of the wave animation
local nextSlide = 0

-- Create the sprite for the beach background
local function beachSprite(imgTable)
    local sprite = playdate.graphics.sprite.new()
    -- Set properties to fill the background and persist
    sprite:setSize(playdate.display.getSize())
    sprite:setCenter(0, 0)
    sprite:moveTo(0, 0)
    sprite:setZIndex(-32768)
    sprite:setIgnoresDrawOffset(true)
    sprite:setTag(BACKGROUND_TAG)

    -- Set and animate the image for the sprite
    sprite:setImage(imgTable:getImage(1))
    -- Using a timer and image table this way causes fewer redraws than 
    -- an animation and always redrawing the sprite.
    waveAnim = playdate.timer.new(WAVE_SPEED,
        function()
            nextSlide = (nextSlide + 1) % #imgTable
            -- Image index is 1-based rather than 0-based
            sprite:setImage(imgTable:getImage(nextSlide + 1))
        end
    )
    waveAnim.repeats = true

    -- Make collision box to keep the player out of the water
    sprite:setCollideRect(0, 125, 400, 110)

    return sprite
end

return {
    beachSprite = beachSprite
}
