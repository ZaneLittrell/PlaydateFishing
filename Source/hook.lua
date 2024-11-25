import "CoreLibs/sprites"

local function hookSprite(lineImage, lineMask)
    local sprite = playdate.graphics.sprite.new()
    local maskedLine = lineImage:copy()
    maskedLine:setMaskImage(lineMask)
    print(lineImage:getSize())
    print(maskedLine:getSize())
    sprite:setImage(maskedLine)
    sprite:setSize(64, 64)
    -- Set moveTo basis as the bottom-left of the line
    --sprite:setCenter(11, 64)

    return sprite
end

return {
    hookSprite = hookSprite
}
