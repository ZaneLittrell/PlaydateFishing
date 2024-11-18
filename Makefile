.PHONY: clean

Fishing.pdx: Source/*
	pdc Source Fishing.pdx

clean:
	rm -rf Fishing.pdx
