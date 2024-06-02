for file in "*.mp4"; do
    mv "$file" "${file// /.}"
    mv "$file" "${file// ) /.}"
    mv "$file" "${file// ( /.}"
done

