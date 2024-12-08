.PHONY: all 
.PHONY: clean

idle-slides = player-idle-1.png player-idle-2.png
cast-slides = player-cast-1.png player-cast-2.png player-cast-3.png player-cast-4.png player-cast-5.png player-cast-6.png
beach-slides = beach-1.png beach-2.png beach-3.png beach-4.png
all-single-images = player.png beach.png $(idle-slides) $(beach-slides) $(cast-slides)
all-images = player-idle-table-64-64.png beach-table-400-240.png player-cast-table-64-64.png $(all-single-images)


all: $(all-images)

player-idle-table-64-64.png: $(idle-slides)
	montage -mode concatenate $(idle-slides) player-idle-table-64-64.png

player-cast-table-64-64.png: $(cast-slides)
	montage -mode concatenate $(cast-slides) player-cast-table-64-64.png

beach-table-400-240.png: $(beach-slides)
	montage -mode concatenate $(beach-slides) beach-table-400-240.png

clean:
	rm -f $(all-images)

$(all-single-images): %.png: %.mvg
	magick mvg:$< $@
