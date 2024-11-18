import "CoreLibs/animation"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

--#region Local variables

-- Wave animation speed
local WAVE_SPEED <const> = 200
-- The full tag value
local FULL_TAG <const> = 0xFF
-- Tag for the background sprite
local BACKGROUND_TAG <const> = 0xFF
-- Tag for the fish moving in the positive x direction
local FISH_FORWARD_TAG <const> = 0x8

-- Playdate graphics object
local gfx <const> = playdate.graphics
-- Foreground color
local fgColor <const> = gfx.kColorBlack
-- Background color
local bgColor <const> = gfx.kColorWhite
-- Seconds elapsed since the game started
local elapsedTime = 0
-- Wave animation object
local waveAnim = nil
-- Fish image
local fishImg = nil

--#endregion Local variables

--#region Util functions

-- Load an image and handle any errors
local function loadImage(imgPath)
    local img, err = gfx.image.new(imgPath)
    if table == nil then
        error(err)
    end
    return img
end

-- Load an imagetable and handle any errors
local function loadImagetable(tablePath)
    local table, err = gfx.imagetable.new(tablePath)
    if table == nil then
        error(err)
    end
    return table
end

-- Fish update method
local function fishUpdate(self)
    -- TODO turn this into a closure that works with different boundaries as parameters
    if self.x > 200 then
        -- Unset fish forward tag
        self:setTag(self:getTag() & (FULL_TAG ~ FISH_FORWARD_TAG))
        print("Flipping around (back)")
    elseif self.x < 100 then
        -- Set fish forward tag
        self:setTag(self:getTag() | FISH_FORWARD_TAG)
        print("Flipping around (forward)")
    end

    -- Check if the forward tag is set
    if (self:getTag() & FISH_FORWARD_TAG) ~= 0 then
        self:moveTo(self.x + 1, self.y)
        print("Moving forward")
    else
        self:moveTo(self.x - 1, self.y)
        print("Moving back")
    end
end

-- Create a fish sprite
local function fishSprite(fishImage, x, y)
    local sprite = playdate.graphics.sprite.new(fishImage)
    sprite:moveTo(x, y)
    sprite.update = fishUpdate
    return sprite
end

--#endregion Util functions

--#region Local functions

-- Initialization function
local function init()
    -- Set colors
    gfx.setColor(fgColor)
    gfx.setBackgroundColor(bgColor)

    -- Load wave animation
    local waveTable = loadImagetable("fullWave")
    waveAnim = gfx.animation.loop.new(WAVE_SPEED, waveTable, true)
    -- Draw wave in the background
    gfx.sprite.setBackgroundDrawingCallback(
        function(x, y, width, height)
            -- x,y,width,height is the updated area in sprite-local coordinates
            -- The clip rect is already set to this area, so we don't need to set it ourselves
            waveAnim:draw(0, 0)
        end
    )
    -- Tag background sprite since it's the only one that exists yet
    gfx.sprite.performOnAllSprites(
        function (sprite)
            sprite:setTag(BACKGROUND_TAG)
        end
    )

    -- Load fish image
    fishImg = loadImage("fish")
    local sprite = fishSprite(fishImg, 120, 20)
    sprite:add()
end

--#endregion Local functions

--#region Playdate overrides

---@diagnostic disable-next-line: duplicate-set-field
function playdate.AButtonDown()
    -- Show all sprites
    gfx.sprite.performOnAllSprites(
        function (sprite)
            sprite:setVisible(true)
        end
    )
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.BButtonDown()
    -- Hide all sprites besides background
    gfx.sprite.performOnAllSprites(
        function (sprite)
            if sprite:getTag() ~= BACKGROUND_TAG then
                sprite:setVisible(false)
            end
        end
    )
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.update()
    local dt = 1/20
    elapsedTime = elapsedTime + dt

    gfx.sprite.update()
    -- Always redraw background since it's animated
    gfx.sprite.redrawBackground()
end

--#endregion Playdate overrides

init()
