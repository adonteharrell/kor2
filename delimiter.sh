for file in *.mp4; do
    newfile="${file// /}"
    newfile="${newfile//)/.}"
    newfile="${newfile//(/.}"
    mv "$file" "$newfile"
done
