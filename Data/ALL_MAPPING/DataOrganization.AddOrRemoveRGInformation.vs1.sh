#!/bin/sh

#######
#
#	Description
#	
#
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Working variables:" $mainDir1 $baseFile1
echo ""

#Variables: $mainDir1, $baseFile1
POOLID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { print $1, "_", $2; }'` 
#libraryID=`echo $baseFile1 | perl -ane 'if ($F[0] =~ m/(.*)(01|02)\..*RL.*/) { print $1; }'`
libraryID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { print $1; }'` 

if [ -z "$POOLID" ]; then
	echo "Error1a - Variable \$POOLID not set ($mainDir1 $baseFile1 $refFileFlag1)"
	exit
fi

if [ -z "$libraryID" ]; then
	echo "Error1b - Variable \$libraryID not set ($mainDir1 $baseFile1 $refFileFlag1)"
	exit
fi

#echo $POOLID $libraryID

cd $mainDir1
#mainDir Ex = /home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_1-46/POOL01-01RL
#ID baseFile1 Ex = HSMYABW02.RL1
#SM POOLID Ex = POOL01_01RL
#LB libraryID Ex = POOL01
#/home/shared/software/bwa/bwa-0.7.4/bwa mem -M -R "@RG\tID:${baseFile1}\tSM:${POOLID}\tLB:${libraryID}" $refFile2 $baseFile1.fastq.gz | gzip > $baseFile1.sam.gz #Including RG information header stuff

#cp -p $baseFile1.sam.gz OLD1.${baseFile1}.sam.bckup.gz

gunzip $baseFile1.sam.gz

#java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/AddOrReplaceReadGroups.jar INPUT=$baseFile1.sam OUTPUT=$baseFile1.sam.2 RGID=$baseFile1 RGSM=$POOLID RGLB=$libraryID RGPL="asdadad" RGPU="asdadad" 
/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/AddOrReplaceReadGroups.jar INPUT=$baseFile1.sam OUTPUT=$baseFile1.2.sam RGID=$baseFile1 RGSM=$POOLID RGLB=$libraryID RGPL="LS454" RGPU="asdadad" 

cat $baseFile1.2.sam | perl -lane 'if ($F[0] =~ m/\@RG/) { my @array1; foreach my $val1 (@F) { if ($val1 =~ m/(RG|ID|SM|LB|PL)/) { push (@array1, $val1); } } print join("\t", @array1) } elsif ($F[0] =~ m/\@HD/) { } else { print join("\t", @F) } ' | gzip > $baseFile1.sam.gz
#cat $baseFile1.sam | perl -lane 'if ($F[0] =~ m/\@RG/) { print join("\t", @F), "\tPL:LS454"; } else { print join("\t", @F); } ' | gzip > $baseFile1.sam.gz

rm $baseFile1.sam $baseFile1.2.sam
#rm $baseFile1.sam 

zcat $baseFile1.sam.gz | /home/shared/software/samtools/samtools-0.1.19/samtools view -bSu - | /home/shared/software/samtools/samtools-0.1.18/samtools sort -o - samtools_csort_tmp_$baseFile > $baseFile1.preGATK.bam
/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFile1.preGATK.bam $baseFile1.preGATK.bai

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
