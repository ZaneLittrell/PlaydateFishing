local beach = import "beach"
local fish = import "fish"
local player = import "player"
local util = import "util"

-- Tag for the background sprite
local BACKGROUND_TAG <const> = 0xFF

-- Playdate sprite object
local pSprite <const> = playdate.graphics.sprite

-- Load all assets
local function loadAssets()
    local waveTable = util.loadImagetable("Images/fullWave")
    local fishImage = util.loadImage("Images/fish")
    local playerImage = util.loadImage("Images/player")

    return {
        waveTable = waveTable,
        fishImage = fishImage,
        playerImage = playerImage
    }
end

-- Make and add beach sprite
local function initBeach(assets)
    local beachSprite = beach.beachSprite(assets.waveTable)
    beachSprite:add()
end

-- Make and add fish sprites
local function initFish(assets)
    for i = 1, 3, 1 do
        local x = math.random(80, 320)
        local leftBound = math.random(50, 120)
        local rightBound = math.random(200, 350)
        local speed = math.random(25, 100) / 100
        local sprite = fish.fishSprite(
            assets.fishImage,
            x,
            i * 20,
            leftBound,
            rightBound,
            speed
        )
        sprite:add()
    end
end

-- Make and add player sprite
local function initPlayer(assets)
    local playerSprite = player.playerSprite(assets.playerImage, 192, 200)
    playerSprite:add()
end

-- Initialization function
local function init()
    local assets = loadAssets()
    initBeach(assets)
    initFish(assets)
    initPlayer(assets)
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
