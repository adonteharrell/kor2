#!/bin/bash

cd /movies
    echo "<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filthtown Movies</title>
</head>
<body>
<center>
<img src="miranda.gif" alt="Babe" width="250" height="250">
<br><br>
<center>" > /movies/index.html    

for i in *.mp4; do
    echo "<a href="${i}.html">$i</a><br> <br>" >> /movies/index.html
done

echo "</center></body></html>" >> /movies/index.html

# Remove duplicate entries.
#awk '!seen[$0]++' index.html > index2.tmp && mv index2.tmp index.html
