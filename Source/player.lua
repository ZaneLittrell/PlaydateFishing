import "CoreLibs/sprites"

-- Length of each frame in milliseconds
local CAST_SPEED <const> = 200

-- Logic to execute when the player sprite is updated
local function playerUpdate(playerImage, castTable)
    local castAnim = nil
    return function(self)
        -- If currently animating, exit immediately
        if castAnim ~= nil then
            return
        end

        if playdate.buttonIsPressed(playdate.kButtonA) then
            -- Draw cast animation

            local timerDuration = math.floor(CAST_SPEED * #castTable)
            -- Make value timer where the value is the frame of the image table
            castAnim = playdate.timer.new(timerDuration, 1, #castTable)
            -- Animate each frame from the table
            castAnim.updateCallback = function(timer)
                local nextFrame = math.floor(timer.value)
                self:setImage(castTable:getImage(nextFrame))
            end
            -- Switch back to idle player image
            castAnim.timerEndedCallback = function ()
                self:setImage(playerImage)
                castAnim = nil
            end
        end

        -- Move the player
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
end

-- Create the player sprite, There should only be one created
local function playerSprite(playerImage, x, y, castTable)
    local sprite = playdate.graphics.sprite.new(playerImage)
    sprite:moveTo(x, y)
    sprite.update = playerUpdate(playerImage, castTable)
    -- TODO tweak rectangle to match visible player size
    sprite:setCollideRect(0, 0, sprite:getSize())
    return sprite
end

return {
    playerSprite = playerSprite
}
