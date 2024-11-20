local beach = import "beach"
local fish = import "fish"
local player = import "player"
local util = import "util"

-- Tag for the background sprite
local BACKGROUND_TAG <const> = 0xFF

-- Playdate sprite object
local pSprite <const> = playdate.graphics.sprite

-- Initialization function
local function init()
    -- Load wave animation
    local waveTable = util.loadImagetable("fullWave")
    local beachSprite = beach.beachSprite(waveTable)
    beachSprite:add()

    -- Make fish sprites
    local fishImg = util.loadImage("fish")
    for i = 1, 3, 1 do
        local x = math.random(80, 320)
        local leftBound = math.random(50, 120)
        local rightBound = math.random(200, 350)
        local speed = math.random(25, 100) / 100
        local sprite = fish.fishSprite(fishImg, x, i * 20, leftBound, rightBound, speed)
        sprite:add()
    end

    -- Make player sprite
    local playerImg = util.loadImage("player")
    local playerSprite = player.playerSprite(playerImg, 192, 200)
    playerSprite:add()
end

--#region Playdate overrides

---@diagnostic disable-next-line: duplicate-set-field
function playdate.AButtonDown()
    -- Show all sprites
    pSprite.performOnAllSprites(
        function (sprite)
            sprite:setVisible(true)
        end
    )
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.BButtonDown()
    -- Hide all sprites besides background
    pSprite.performOnAllSprites(
        function (sprite)
            if sprite:getTag() ~= BACKGROUND_TAG then
                sprite:setVisible(false)
            end
        end
    )
end

---@diagnostic disable-next-line: duplicate-set-field
function playdate.update()
    pSprite.update()
    playdate.timer.updateTimers()
end

--#endregion Playdate overrides

init()
