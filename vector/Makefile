.PHONY: all 
.PHONY: clean

idle-slides = player-idle-1.png player-idle-2.png
beach-slides = beach-1.png beach-2.png beach-3.png beach-4.png
all-single-images = player.png beach.png $(idle-slides) $(beach-slides)
all-images = player-idle-table-64-64.png beach-table-400-240.png $(all-single-images)


all: $(all-images)

player-idle-table-64-64.png: $(idle-slides)
	montage -mode concatenate $(idle-slides) player-idle-table-64-64.png

beach-table-400-240.png: $(beach-slides)
	montage -mode concatenate $(beach-slides) beach-table-400-240.png

clean:
	rm -f $(all-images)

$(all-single-images): %.png: %.mvg
	magick mvg:$< $@
