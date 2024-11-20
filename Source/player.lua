import "CoreLibs/sprites"

-- Logic to execute when the player sprite is updated
local function playerUpdate(self)
    local goalX, goalY = self.x, self.y

    if playdate.buttonIsPressed(playdate.kButtonUp) then
        goalY -= 1
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        goalY += 1
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        goalX -= 1
    elseif playdate.buttonIsPressed(playdate.kButtonRight) then
        goalX += 1
    end

    -- TODO handle collisions
    self:moveWithCollisions(goalX, goalY)
end

-- Create the player sprite, There should only be one created
local function playerSprite(playerImage, x, y)
    local sprite = playdate.graphics.sprite.new(playerImage)
    sprite:moveTo(x, y)
    sprite.update = playerUpdate
    -- TODO tweak rectangle to match visible player size
    sprite:setCollideRect(0, 0, sprite:getSize())
    return sprite
end

return {
    playerSprite = playerSprite
}
