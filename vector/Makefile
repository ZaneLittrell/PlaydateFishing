.PHONY: all 
.PHONY: clean
.PHONY: idle

idle-slides = player-idle-1.png player-idle-2.png
all-images = player.png $(idle-slides)

all: $(all-images)

idle: $(idle-slides)

clean:
	rm -f $(all-images)

$(all-images): %.png: %.mvg
	magick mvg:$< $@
