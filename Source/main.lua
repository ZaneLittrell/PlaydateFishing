local beach = import "beach"
local fish = import "fish"
local player = import "player"
local util = import "util"

--- Playdate sprite object
local pSprite <const> = playdate.graphics.sprite

---@alias assetstable { beachTable: pd_imagetable, fishImage: pd_image, playerIdleTable: pd_imagetable, castTable: pd_imagetable, lineImage: pd_image, lineMask: pd_image }

--- Load all assets
---@return assetstable
local function loadAssets()
    local beachTable = util.loadImagetable("Images/beach")
    local fishImage = util.loadImage("Images/fish")
    local playerIdleTable = util.loadImagetable("Images/player-idle")
    local castTable = util.loadImagetable("Images/player-cast")
    local lineImage = util.loadImage("Images/line")
    local lineMask = util.loadImage("Images/line-mask")

    return {
        beachTable = beachTable,
        fishImage = fishImage,
        playerIdleTable = playerIdleTable,
        castTable = castTable,
        lineImage = lineImage,
        lineMask = lineMask
    }
end

--- Make and add beach sprite
---@param assets assetstable
local function initBeach(assets)
    local beachSprite = beach.beachSprite(assets.beachTable)
    beachSprite:add()
end

--- Make and add fish sprites
--- @param assets assetstable
local function initFish(assets)
    for i = 1, 3, 1 do
        local x = math.random(80, 320)
        local leftBound = math.random(50, 120)
        local rightBound = math.random(200, 350)
        local speed = math.random(25, 100) / 100
        local sprite = fish.fishSprite(
            assets.fishImage,
            x,
            i * 20 + 160,
            leftBound,
            rightBound,
            speed
        )
        sprite:add()
    end
end

--- Make and add player sprite
--- @param assets assetstable
local function initPlayer(assets)
    local playerSprite = player.playerSprite(
        assets.playerIdleTable,
        192,
        80,
        assets.castTable
    )
    playerSprite:add()
end

--- Initialization function
local function init()
    local assets = loadAssets()
    initBeach(assets)
    initFish(assets)
    initPlayer(assets)
end

--#region Playdate overrides

function playdate.update()
    pSprite.update()
    playdate.timer.updateTimers()
end

--#endregion Playdate overrides

init()
