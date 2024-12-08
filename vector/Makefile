.PHONY: all 
.PHONY: clean
.PHONY: idle

idle-slides = player-idle-1.png player-idle-2.png
all-images = player.png $(idle-slides)

all: $(all-images)

idle: $(idle-slides)

player-idle-table-64-64.png: $(idle-slides)
	montage -mode concatenate $(idle-slides) player-idle-table-64-64.png

clean:
	rm -f $(all-images)

$(all-images): %.png: %.mvg
	magick mvg:$< $@
