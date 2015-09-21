#!/bin/sh

for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
do
	ls -lrt /home/pg/ALL_MAPPING/$dir/. | awk '{ print $9 }' > $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt
done
