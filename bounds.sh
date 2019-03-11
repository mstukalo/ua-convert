#!/bin/bash

# Creates bounds from splitted files

for filename in $(find mkgmap-stranger/_split/*.pbf 2> /dev/null); do
	java -cp executable/mkgmap/mkgmap.jar uk.me.parabola.mkgmap.reader.osm.boundary.BoundaryPreprocessor $filename executable/mkgmap/bounds
done
