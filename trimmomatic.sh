#!/bin/sh

mData = "<some data path>"

# Creat a list of filenames from the data folder
find ${mDATA} -maxdepth 1 -name "SLX*" -print |\
cut -d "/" -f4 |\
cut -c1-36 |\
sort |\
uniq > filelist.txt

for F in $(cat filelist.txt) ; do
	FULLSTRING=$F

	java -jar /opt/Trimmomatic-0.36/trimmomatic-0.36.jar \
	SE -threads 20 "${mDATA} /${FULLSTRING}.fq.gz" "${mDATA} /${FULLSTRING}.fq.gz" \
	ILLUMINA CLIP:NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
	SLIDINGWINDOW:4:15 MINLEN:36

	done
