import "CoreLibs/animation"
import "CoreLibs/graphics"

--#region Local variables

-- Wave animation speed
local WAVE_SPEED <const> = 200

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

    -- Load fish image
    fishImg = loadImage("fish")
end

--#endregion Local functions

--#region Playdate overrides

---@diagnostic disable-next-line: duplicate-set-field
function playdate.update()
    local dt = 1/20
    elapsedTime = elapsedTime + dt

    if waveAnim ~= nil then
        waveAnim:draw(0, 0)
    end
    if fishImg ~= nil then
        fishImg:draw(120, 20)
    end
end

--#endregion Playdate overrides

init()
