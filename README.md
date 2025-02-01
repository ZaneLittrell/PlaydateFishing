# PlaydateFishing

This is my attempt at making a simple Playdate game with Lua. If this goes well, I might try porting this to the C API to get a better feel for that.

## Images

All image assets for this game are initially created as [Magick Vector Graphics (MVG)](https://imagemagick.org/script/magick-vector-graphics.php) files. This is a syntax, somewhat based off of the SVG format, which allows for defining the image in terms of vecotrs. The ImageMagick program can then be used to render these files into PNG files for use in the game.

The scripts needed to rasterize these vector images are all contained in the Makefile under the `vector/` directory. After running the `make` scripts, the PNG files should be copied to the `Source/Images/` directory.

## Linux Playdate Access

After connecting the Playdate with USB, run the command

`pdutil /dev/ttyACM0 datadisk`

This will disconnect the Playdate at `/dev/ttyACM0` and add the data partition of the Playdate as a SCSI device, at the next available disk such as `/dev/sdb1`. From here, run `sudo mount /dev/sdb1 PlaydateData` to mount the Playdate to the local PlaydateData directory. Games or any other data can be read/written in the local directory.

When finished, run `umount PlaydateData` to unmount the Playdate.
