import "CoreLibs/sprites"

--- Playdate graphics object
local gfx <const> = playdate.graphics

--- Width of the line image in px
local LINE_IMAGE_WIDTH <const> = 64
--- Height of the line image in px
local LINE_IMAGE_HEIGHT <const> = 64
--- Start x-coordinate of the line
local LINE_IMAGE_X1 <const> = 11
--- Width of the line in px
local STROKE_WIDTH <const> = 3

--- Draw the line and hook into an image
---@param length integer # Length of the line in px
---@param angle number # Angle of the line in radians
---@return pd_image # Image of the line and hook
local function drawHook(length, angle)
    if angle < 0 or angle > math.pi then
        error('Angle must be between 0 and π radians')
    end
    if length < 0 or length > LINE_IMAGE_HEIGHT then
        error('Length must be between 0 and ' .. LINE_IMAGE_HEIGHT)
    end

    local hookImage = gfx.image.new(LINE_IMAGE_WIDTH, LINE_IMAGE_HEIGHT)
    local x2 = length * math.sin(angle) + LINE_IMAGE_X1
    local y2 = length * math.cos(angle)

    gfx.lockFocus(hookImage)

    gfx.setLineWidth(STROKE_WIDTH + 2)
    gfx.setLineCapStyle(gfx.kLineCapStyleRound)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawLine(LINE_IMAGE_X1, LINE_IMAGE_HEIGHT, x2, y2)

    gfx.setLineWidth(STROKE_WIDTH)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawLine(LINE_IMAGE_X1, LINE_IMAGE_HEIGHT, x2, y2)

    gfx.unlockFocus()

    return hookImage
end

--- Create the sprite for the fishing line and hook
---@return pd_sprite
local function hookSprite()
    local sprite = gfx.sprite.new()
    --local maskedLine = lineImage:copy()
    --maskedLine:setMaskImage(lineMask)
    --sprite:setImage(maskedLine)
    sprite:setImage(gfx.image.new(LINE_IMAGE_WIDTH, LINE_IMAGE_HEIGHT))
    sprite:setSize(LINE_IMAGE_WIDTH, LINE_IMAGE_HEIGHT)
    -- Set moveTo basis as the bottom-left of the line
    --sprite:setCenter(11, 64)

    return sprite
end

return {
    hookSprite = hookSprite,
    drawHook = drawHook
}
