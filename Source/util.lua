--- Playdate graphics object
local gfx <const> = playdate.graphics

--- Load an image and handle any errors
---@param imgPath string # Path to the image
---@return pd_image # Image stored at the path
local function loadImage(imgPath)
    local img, err = gfx.image.new(imgPath)
    if table == nil then
        error(err)
    end
    return img
end

--- Load an imagetable and handle any errors
---@param tablePath string # Path to the image table
---@return pd_imagetable|{ [integer]: pd_image } # Image table from the file
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
