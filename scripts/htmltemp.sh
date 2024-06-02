#!/bin/bash

cd /movies
for i in *.mp4; do
    touch /movies/${i}.html
    echo "<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="styles.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Local Video Player</title>
</head>
<body>
<center>
<h1>"$i"</h1><br>
<video width="640" height="360" controls>
    <source src="${i}" type="video/mp4">
    Your browser does not support the video tag.
</video>
</center>
</body>
</html><center>" > "/movies/${i}.html" 
done


