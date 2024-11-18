import "CoreLibs/animation"
import "CoreLibs/graphics"

--#region Local variables

local WAVE_HALF_AMPLITUDE <const> = 25
local WAVE_PERIOD <const> = 70

local gfx <const> = playdate.graphics
local fgColor <const> = gfx.kColorBlack
local bgColor <const> = gfx.kColorWhite
local elapsedTime = 0
local wavePhase = 0
local waveAnim

--#endregion Local variables

--#region Local functions

-- Initialization function
local function init()
    gfx.setColor(fgColor)
    gfx.setBackgroundColor(bgColor)
    local table, err = gfx.imagetable.new("wave")
    if table == nil then
        error(err)
    else
        waveAnim = gfx.animation.loop.new(400, table, true)
    end
end

-- Draw a wave on the beach
local function drawWave()
    gfx.drawSineWave(0, 100, 400, 100, WAVE_HALF_AMPLITUDE, WAVE_HALF_AMPLITUDE, WAVE_PERIOD, wavePhase)
end

--#endregion Local functions

--#region Playdate overrides

---@diagnostic disable-next-line: duplicate-set-field
function playdate.leftButtonDown()
    print("Left pressed")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.rightButtonDown()
    print("Right pressed")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.upButtonDown()
    print("Up pressed")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.downButtonDown()
    wavePhase = 50
    print("Down pressed")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.leftButtonUp()
    print("Left released")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.rightButtonUp()
    print("Right released")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.upButtonUp()
    print("Up released")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.downButtonUp()
    wavePhase = 0
    print("Down released")
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.update()
    local dt = 1/20
    elapsedTime = elapsedTime + dt

    waveAnim:draw(0, 0)
end

--#endregion Playdate overrides

init()
