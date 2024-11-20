import "CoreLibs/sprites"

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

return {
    playerSprite = playerSprite
}
