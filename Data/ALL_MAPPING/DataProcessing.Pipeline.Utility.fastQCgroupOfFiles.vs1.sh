#!/bin/sh

########
#
# Date:
# Description:
#
# Code (c) Michael Turchin 201*
#
########

beginTime1=`perl -e 'print time;'`
date1=`date`
#PBSnodeFile=`cat $PBS_NODEFILE`
#PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBS_NODEFILE} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Working variables:" $mainDir1 $File1
echo ""

#mainDir1 = /data/userdata/pg/michaelt/Data/ALL_MAPPING/FileChunks/
#File1 = DataOrganization.CollectAllIndvMIDRLsffFiles.vs3.WorkingMainFile.Edited.AllfastqFilesSingleLine.chunk1.output 

cd $mainDir1

#cat $mainDir1/$File1 | xargs /home/michaelt/Software/FastQC/fastqc > $mainDir1/$File1.fastQC

cat $mainDir1/$File1 | xargs zcat | /home/michaelt/Software/FastQC/fastqc -o $mainDir1 stdin --extract

#unzip $mainDir1/$File1

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
