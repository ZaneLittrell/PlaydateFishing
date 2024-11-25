import "CoreLibs/sprites"

-- Playdate graphics object
local gfx <const> = playdate.graphics

local LINE_IMAGE_WIDTH <const> = 64
local LINE_IMAGE_HEIGHT <const> = 64
local LINE_IMAGE_X1 <const> = 11
local STROKE_WIDTH <const> = 3

-- Angle is in radians
-- Length is the length of the hypotenuse
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

    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, LINE_IMAGE_WIDTH, LINE_IMAGE_HEIGHT)

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

local function hookSprite(lineImage, lineMask)
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
