#!/bin/bash

cd "/videos"

echo "Moving movie(s) to index directory..."
for i in *.mp4; do
    cp -u -v "${i}" /movies/"$i"
done

# Run scripts to generate html pages for movies. 
sh /movies/htmltemp.sh

# Run scripts to add links to webpage. 
sh /movies/indextemp.sh

