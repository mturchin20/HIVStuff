#!/bin/sh

#######
#
#	Description
#	
#	Note 20130522: mergeFlag1 is never expected to equal 1 now; code is being kept there for the time being to maintain a physical record of the thought process/logic at that time. A separate script is being created that will perform the same functions, collecting /all/ .bam files present in the directory on the per individual level, rather than explicitly just combining the two PTP regions across the single plate/run (e.g. if two separate runs were done or an individual, collect all .bams from all sections of the PTPs for each run and then do the aggregate MarkDup/BQSR steps. Using Pool##_RL## as the sample full/true name)
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Working variables:" $mainDir1 $baseFile1 $refFileFlag1
echo ""

#Variables: $mainDir1, $baseFile1, $refFileFlag1
refFile1=""
refFile2="/tmp/$PBS_JOBID/human_g1k_v37.fasta"
POOLID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { print $1, ":", $2; }'` 
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

echo $POOLID $libraryID

mkdir /tmp/$PBS_JOBID
cd /tmp/$PBS_JOBID

#cd $mainDir1

if [ $refFileFlag1  == 0 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version0/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 1 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version1/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 2 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version2/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 3 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version3/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 4 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version4/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 5 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version5/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 6 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version6/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 7 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version7/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 8 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version8/human_g1k_v37.fasta"
elif [ $refFileFlag1 == 9 ] ; then
	refFile1="/home/michaelt/Data/HumanGenome/GRCh37/Version9/human_g1k_v37.fasta"
else
	echo "Error2a - refFileFlag1 $refFileFlag1 does not contain an expected version number (0-9) for bwa's reference files"
fi

cp -p $refFile1* /tmp/$PBS_JOBID/.
refFile1dict=`echo $refFile1 | perl -ane 'if ($F[0] =~ m/(.*)(fasta)/) { print $1 . "dict"; }'`
cp -p $refFile1dict /tmp/$PBS_JOBID/.

cp -p $mainDir1/$baseFile1.fastq.gz /tmp/$PBS_JOBID/.

date | xargs echo "Pre bwa timepoint:"

#mainDir Ex = /home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_1-46/POOL01-01RL
#ID baseFile1 Ex = HSMYABW02.RL1
#SM POOLID Ex = POOL01:01RL
###LB libraryID Ex = HSMYABW
#LB libraryID Ex = POOL01
#ID=$baseFile1, SM=$POOLID, LB=$libraryID
#ID=$baseFile1, SM=$POOLID, LB=$libraryID, PL="LS454"
#/home/shared/software/bwa/bwa-0.7.4/bwa mem -M $refFile2 $baseFile1.fastq.gz | gzip > $baseFile1.sam.gz
/home/shared/software/bwa/bwa-0.7.4/bwa mem -M -R "@RG\tID:${baseFile1}\tSM:${POOLID}\tLB:${libraryID}\tPL:LS454" $refFile2 $baseFile1.fastq.gz | gzip > $baseFile1.sam.gz #Including RG information header stuff
#/home/shared/software/bwa/bwa-0.7.4/bwa mem -M -R "@RG\tID:${baseFile1}\tSM:${POOLID}\tLB:${libraryID}" $refFile2 $baseFile1.fastq.gz | gzip > $baseFile1.sam.gz #Including RG information header stuff

date | xargs echo "Post bwa timepoint:"

zcat $baseFile1.sam.gz | /home/shared/software/samtools/samtools-0.1.19/samtools view -bSu - | /home/shared/software/samtools/samtools-0.1.18/samtools sort -o - samtools_csort_tmp_$baseFile > $baseFile1.preGATK.bam
/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFile1.preGATK.bam $baseFile1.preGATK.bai

#mv $baseFile1.preGATK.bam $baseFile1.preGATK.noRGbam
#java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/

date | xargs echo "Post initial samtools timepoint:"

mv /tmp/$PBS_JOBID/$baseFile1.sam* /tmp/$PBS_JOBID/$baseFile1.pre* $mainDir1/. 

#Only being kept/used for one round to remove the below-mentioned files for the time being
#cd $mainDir1
#rm $baseFile1.QCed.sam.gz $baseFile1.QCed.preGATK.bam $baseFile1.QCed.preGATK.bai

rm -r /tmp/$PBS_JOBID

#bwa mem ref.fa reads.fq > aln-se.sam
#Old, previously used commands in a former pipeline from an earlier project
#zcat $FILE1.sam.gz | samtools view -bSu - | samtools sort -n -o - samtools_nsort_tmp$2$3$4 | samtools fixmate /dev/stdin /dev/stdout | samtools sort -o - samtools_csort_tmp$2$3$4 | samtools rmdup /dev/stdin /dev/stdout > $FILE1.bam
#samtools index $FILE1.bam $FILE1.bai
#samtools view -b -q 30 $FILE1.bam chrX > $FILE1.qThrsh30.chrX.bam


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
