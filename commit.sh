for file in ./chuncks/*;
do
  echo "Updating $file";
  if [ $(find "$file" | wc -l) -gt 1000 ]; then
    for i in {0..9};
    do
      # create a new variable that contain file with excaped space and -
      file2=$(echo "$file" | sed 's/ /\\ /g' | sed 's/-/\\-/g')
      # test if more than a 1000 files in the folder
      if [ $(find "$file" | wc -l) -gt 10000 ]; then
        for j in {0..9};
        do
          git add "$file/$i$j*";
          git commit -m "Updating $file $i$j";
          git push;
          sleep .5;
        done
      fi

      git add "$file/$i*";
      git commit -m "Updating $file $i";
      git push;
      sleep .5;
    done
  fi
  git add "$file*";
  git commit -m "Updating $file";
  git push;
  sleep .5;
done