-- Playdate graphics object
local gfx <const> = playdate.graphics

-- Load an image and handle any errors
local function loadImage(imgPath)
    local img, err = gfx.image.new(imgPath)
    if table == nil then
        error(err)
    end
    return img
end

-- Load an imagetable and handle any errors
local function loadImagetable(tablePath)
    local table, err = gfx.imagetable.new(tablePath)
    if table == nil then
        error(err)
    end
    return table
end

return {
    loadImage = loadImage,
    loadImagetable = loadImagetable
}
