# PlaydateFishing

This is my attempt at making a simple Playdate game with Lua. If this goes well, I might try porting this to the C API to get a better feel for that.

## Images

The X11 bitmap program is very simple, but easy to use for creating smaller images. Bitmaps should be created at 16x16 resolution and saved in the `bitmaps` directory. From there, running `magick bitmaps/source.xbm -magnify -magnify Source/Images/output.png` will create a more smoothed out version of that image at 64x64px resolution.

Animations can be made by creating each slide as individual .xbm files and then stitching them together with `montage -mode concatenate animation-*.xbm animation-table-16-16.png`. That command will join all `animation-n.xbm` files into one `animation-table-16-16.png`.

## Linux Playdate Access

After connecting the Playdate with USB, run the command

`pdutil /dev/ttyACM0 datadisk`

This will disconnect the Playdate at `/dev/ttyACM0` and add the data partition of the Playdate as a SCSI device, at the next available disk such as `/dev/sdb1`. From here, run `sudo mount /dev/sdb1 PlaydateData` to mount the Playdate to the local PlaydateData directory. Games or any other data can be read/written in the local directory.

When finished, run `umount PlaydateData` to unmount the Playdate.
