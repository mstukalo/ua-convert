#!/bin/bash

mkdir results
mkdir mkgmap-stranger/_intermediate
mkdir mkgmap-stranger/_split

rm -r results/*
rm -r mkgmap-stranger/_intermediate/*
rm -r mkgmap-stranger/_split/*
rm UA.osm.pbf

wget -N http://data.gis-lab.info/osm_dump/dump/latest/UA.osm.pbf

cd mkgmap-stranger

echo Splitting
java -Xmx1G -jar ../executable/splitter/splitter.jar ../UA.osm.pbf --output-dir=_split

echo Creating -uk map with mkgmap
java -Xmx1000M -jar ../executable/mkgmap/mkgmap.jar --style-file=stranger-uk/stranger --family-id=45 --output-dir=_intermediate --read-config=ukrstranger.cfg stranger-uk/stranger.txt _split/template.args

echo Copying result files
today=$(date +%Y-%m-%d)
cp _intermediate/gmapsupp.img ../results/OSM\ Ukraine\ $today.img
cp _intermediate/stranger.typ ../results/stranger.typ

cd ..

# cleanup
rm -r mkgmap-stranger/_intermediate/*
rm -r mkgmap-stranger/_split/*
rm UA.osm.pbf
