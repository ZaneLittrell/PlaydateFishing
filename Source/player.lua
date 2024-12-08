import "CoreLibs/sprites"

local hookLib = import "hook"

-- Length of each frame in milliseconds
local CAST_SPEED <const> = 200
-- Length of each frame in milliseconds
local IDLE_SPEED <const> = 500

-- Sprite for the hook that the player casts
local hook;
-- Current slide index (0-based) for animation
local animSlide = 0;
-- Animation timer for idle animation
local idleAnim = nil;

-- Logic to execute when the player sprite is updated
local function playerUpdate(playerIdleTable, castTable)
    local castAnim = nil
    return function(self)
        -- If currently animating, exit immediately
        if castAnim ~= nil then
            return
        end

        if playdate.buttonIsPressed(playdate.kButtonA) then
            -- Pause idle animation
            idleAnim:pause()
            -- Draw cast animation

            local timerDuration = math.floor(CAST_SPEED * #castTable)
            -- Make value timer where the value is the frame of the image table
            castAnim = playdate.timer.new(timerDuration, 1, #castTable + 1)
            -- Animate each frame from the table
            castAnim.updateCallback = function(timer)
                local nextFrame = math.floor(timer.value)
                self:setImage(castTable:getImage(nextFrame))
            end
            -- Add the rest of the line that's been cast
            castAnim.timerEndedCallback = function ()
                print('Adding hook sprite')
                local hookImage = hookLib.drawHook(40, math.pi / 4)
                hook:setImage(hookImage)
                hook:moveTo(self.x, self.y - 64)
                hook:add()
                castAnim = nil
            end
        end

        if playdate.buttonIsPressed(playdate.kButtonB) then
            -- Remove the hook
            hook:remove()
            -- Switch back to idle player animation
            self:setImage(playerIdleTable:getImage(1))
            animSlide = 0
            idleAnim:start()
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
local function playerSprite(playerIdleTable, x, y, castTable)
    hook = hookLib.hookSprite(nil, nil)
    local sprite = playdate.graphics.sprite.new(playerIdleTable:getImage(1))

    idleAnim = playdate.timer.new(IDLE_SPEED,
        function ()
            animSlide = (animSlide + 1) % #playerIdleTable
            -- Image index is 1-based rather than 0-based
            sprite:setImage(playerIdleTable:getImage(animSlide + 1))
        end
    )
    idleAnim.repeats = true

    sprite:moveTo(x, y)
    sprite.update = playerUpdate(playerIdleTable, castTable)
    sprite:setCollideRect(0, 0, sprite:getSize())
    return sprite
end

return {
    playerSprite = playerSprite
}
