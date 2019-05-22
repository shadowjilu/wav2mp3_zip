#!/bin/bash

paths=$(ls -F | sed "s:^:`pwd`/:" | grep 'data')
echo $paths
path_array=(${paths//\/n})

for path in ${path_array[@]}
do
	cd $path
	pwd
	files=$(ls *wav | sed 's/.wav//g')

	for file in $files
	do
		ffmpeg -i $file.wav -vn -ar 44100 -ac 2 -b:a 192k $file.mp3
		mv $file.wav ../wav
	done

	cd ..
	zipname_r=(`echo $path | tr '\/' ' '` ) 
	zipname=${zipname_r[${#zipname_r[@]}-1]}
	zip -r $zipname.zip $zipname/
done
