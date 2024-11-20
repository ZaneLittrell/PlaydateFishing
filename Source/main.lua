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

-- Logic to execute when the player sprite is updated
local function playerUpdate(self)
    local dx = 0
    local dy = 0

    if playdate.buttonIsPressed(playdate.kButtonUp) then
        dy -= 1
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        dy += 1
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        dx -= 1
    elseif playdate.buttonIsPressed(playdate.kButtonRight) then
        dx += 1
    end
    self:moveBy(dx, dy)
end

-- Create the player sprite, There should only be one created
local function playerSprite(playerImage, x, y)
    local sprite = playdate.graphics.sprite.new(playerImage)
    sprite:moveTo(x, y)
    sprite.update = playerUpdate
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

    -- Make fish sprites
    fishImg = loadImage("fish")
    for i = 1, 3, 1 do
        local x = math.random(80, 320)
        local leftBound = math.random(50, 120)
        local rightBound = math.random(200, 350)
        local speed = math.random(25, 100) / 100
        local sprite = fishSprite(fishImg, x, i * 20, leftBound, rightBound, speed)
        sprite:add()
    end

    -- Make player sprite
    local playerImg = loadImage("player")
    local plyrSprite = playerSprite(playerImg, 192, 200)
    plyrSprite:add()
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
