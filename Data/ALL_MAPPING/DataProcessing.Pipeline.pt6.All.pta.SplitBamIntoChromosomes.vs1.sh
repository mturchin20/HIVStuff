#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
#PBSnodeFile=`cat $PBS_NODEFILE`
#PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBS_NODEFILE} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Working variables:" $mainDir1 $baseFileN $I $refFileFlag1
echo ""

#Variables: $mainDir1, $baseFileN, $I, $refFileFlag1
refFile1=""

cd $mainDir1

/home/shared/software/samtools/samtools-0.1.19/samtools view -b ${baseFileN}.bam ${I} > ${baseFileN}.Chr${I}.bam

/home/shared/software/samtools/samtools-0.1.19/samtools index ${baseFileN}.Chr${I}.bam ${baseFileN}.Chr${I}.bai

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
