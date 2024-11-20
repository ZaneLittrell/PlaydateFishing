.PHONY: clean

Fishing.pdx: Source/*.lua Source/Images/*.png
	pdc Source Fishing.pdx

clean:
	rm -rf Fishing.pdx
