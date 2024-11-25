import "CoreLibs/sprites"

local function hookSprite(lineImage)
    local sprite = playdate.graphics.sprite.new()
    sprite:setImage(lineImage)
    sprite:setSize(64, 64)
    -- Set moveTo basis as the bottom-left of the line
    --sprite:setCenter(11, 64)

    return sprite
end

return {
    hookSprite = hookSprite
}
