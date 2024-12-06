.PHONY: clean
.PHONY: all 
.PHONY: all-big

all: player.png

all-big: player-big.png

player-big.png: player.mvg
	magick mvg:player.mvg -scale 800% player-big.png

player.png: player.mvg
	magick mvg:player.mvg player.png

clean:
	rm -f player.png
	rm -f player-big.png
