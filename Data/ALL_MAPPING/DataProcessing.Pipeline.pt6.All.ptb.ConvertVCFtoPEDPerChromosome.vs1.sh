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

mkdir /tmp/$PBS_JOBID
cd /tmp/$PBS_JOBID

#cd $mainDir1

vcftools --gzvcf ${mainDir1}/${baseFileN}.Chr${I}.C50.flt.vcf.gz --plink --out ${baseFileN}.Chr${I}.C50.flt

plink --file ${baseFileN}.Chr${I}.C50.flt --make-bed --out ${baseFileN}.Chr${I}.C50.flt

mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/. 

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
