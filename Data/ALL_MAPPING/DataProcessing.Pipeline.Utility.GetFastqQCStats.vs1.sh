#!/bin/sh

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

RLMIDsffFile="$1"

rm DataPrcoessing.Pipeline.Utility.GetFastqQCStats.vs1.output

OLD_IFS=$IFS
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do

	mainDir=`echo $DirAndsffFile | awk '{ print $1 }'`
	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[9];'`
	baseFile=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	bases=`cat $mainDir/$baseFile.fastq.stats | grep -w "bases" | head -n 1 | awk '{ print $2,": ", $3 }'` 
	reads=`cat $mainDir/$baseFile.fastq.stats | grep -w "reads" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	max=`cat $mainDir/$baseFile.fastq.stats | grep -w "max" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	mean=`cat $mainDir/$baseFile.fastq.stats | grep -w "mean" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	median=`cat $mainDir/$baseFile.fastq.stats | grep -w "median" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	min=`cat $mainDir/$baseFile.fastq.stats | grep -w "min" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	range=`cat $mainDir/$baseFile.fastq.stats | grep -w "range" | head -n 1 | awk '{ print $2, ": ", $3 }'` 
	stddev=`cat $mainDir/$baseFile.fastq.stats | grep -w "stddev" | head -n 1 | awk '{ print $2, ": ", $3 }'` 

#	stats_info      bases   131518517
#	stats_info      reads   201556
#	stats_len       max     1166
#	stats_len       mean    652.52
#	stats_len       median  743
#	stats_len       min     29
#	stats_len       mode    822
#	stats_len       modeval 512
#	stats_len       range   1138
#	stats_len       stddev  271.61


	totalDrop=`cat $mainDir/$baseFile.QCed.fastq.stats | grep Total_reads_dropped | awk '{ print $2 }'`
	justReads=`echo $reads | awk '{ print $3 }'`
	totalPercentDrop=`printf "%.4f" $(echo "$totalDrop/$justReads" | bc -l)`
	minDrop=`cat $mainDir/$baseFile.QCed.fastq.stats | grep DropMin | awk '{ print $2 }'`
	minPercentDrop=`printf "%.4f" $(echo "$minDrop/$justReads" | bc -l)`
	uppBound=`cat $mainDir/$baseFile.fastq.stats | grep UpperBound | awk '{ print $2 }'` 
	maxDrop=`cat $mainDir/$baseFile.QCed.fastq.stats | grep DropMax | awk '{ print $2 }'`
	maxPercentDrop=`printf "%.4f" $(echo "$maxDrop/$justReads" | bc -l)`

	echo $indv1 $baseFile $bases $reads $max $min $mean $median $range $stddev $totalDrop $totalPercentDrop $minDrop $minPercentDrop $uppBound $maxDrop $maxPercentDrop | perl -lane 'print "$F[0] $F[1] $F[2]$F[3] $F[4] $F[5]$F[6] $F[7] $F[8]$F[9] $F[10] $F[11]$F[12] $F[13] $F[14]$F[15] $F[16] $F[17]$F[18] $F[19] $F[20]$F[21] $F[22] $F[23]$F[24] $F[25] totalDropped(%): $F[26] $F[27] minDropped(%): $F[28] $F[29] UpperBoundThresh: $F[30] maxDropped(%): $F[31] $F[32]"; ' >> DataPrcoessing.Pipeline.Utility.GetFastqQCStats.vs1.output

done


