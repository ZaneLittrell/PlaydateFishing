import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Tag for the background sprite
local BACKGROUND_TAG <const> = 0xFF
-- Length of each slide in milliseconds
local WAVE_SPEED <const> = 200
-- Wave animation timer
local waveAnim = nil
-- Current slide of the wave animation
local nextSlide = 1

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
            -- First image is at index 1 not 0
            nextSlide = math.max((nextSlide + 1) % #imgTable, 1)
            sprite:setImage(imgTable:getImage(nextSlide))
        end
    )
    waveAnim.repeats = true

    return sprite
end

return {
    beachSprite = beachSprite
}
