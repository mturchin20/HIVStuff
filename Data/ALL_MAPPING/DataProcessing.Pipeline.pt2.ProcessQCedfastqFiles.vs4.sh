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
#refFile2="/tmp/$PBS_JOBID/human_g1k_v37.fasta"
#POOLID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { print $1, "_", $2; }'` 
POOLID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL[a-zA-Z0-9]+).*(\d\dRL)/) { print $1, "_", $2; }'` 
#libraryID=`echo $baseFile1 | perl -ane 'if ($F[0] =~ m/(.*)(01|02)\..*RL.*/) { print $1; }'`
#libraryID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { print $1; }'` 
libraryID=`echo $mainDir1 | perl -F/ -ane 'if ($F[9] =~ m/(POOL[a-zA-Z0-9]+).*(\d\dRL)/) { print $1; }'` 

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

#cp -p $refFile1* /tmp/$PBS_JOBID/.
#refFile1dict=`echo $refFile1 | perl -ane 'if ($F[0] =~ m/(.*)(fasta)/) { print $1 . "dict"; }'`
#cp -p $refFile1dict /tmp/$PBS_JOBID/.
refFile2=$refFile1

#cp -p $mainDir1/$baseFile1.QCed.fastq.gz /tmp/$PBS_JOBID/.
#cp -p $mainDir1/$baseFile1.QCed.sam.gz /tmp/$PBS_JOBID/.

date | xargs echo "Pre bwa timepoint:"

#mainDir Ex = /home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_1-46/POOL01-01RL
#ID baseFile1 Ex = HSMYABW02.RL1
#SM POOLID Ex = POOL01_01RL
###LB libraryID Ex = HSMYABW
#LB libraryID Ex = POOL01
#ID=$baseFile1, SM=$POOLID, LB=$libraryID
#ID=$baseFile1, SM=$POOLID, LB=$libraryID, PL="LS454"
#/home/shared/software/bwa/bwa-0.7.4/bwa mem -M $refFile2 $baseFile1.fastq.gz | gzip > $baseFile1.sam.gz
/home/shared/software/bwa/bwa-0.7.4/bwa mem -M -R "@RG\tID:${baseFile1}\tSM:${POOLID}\tLB:${libraryID}\tPL:LS454" $refFile2 $mainDir1/$baseFile1.QCed.fastq.gz | gzip > $baseFile1.QCed.sam.gz #Including RG information header stuff

date | xargs echo "Post bwa timepoint:"
totalReadsPreQC=`zcat $baseFile1.QCed.sam.gz | samtools view -S -c -`

#zcat $baseFile1.QCed.sam.gz | /home/shared/software/samtools/samtools-0.1.19/samtools view -F 8 -F 24 -F 256 -F 264 -F 272 -F 280 -bSu - | /home/shared/software/samtools/samtools-0.1.18/samtools sort -o - samtools_csort_tmp_$baseFile > $baseFile1.QCed.preGATK.QCed.bam
#Filtering by a minimum Phred mapping score of 10 and removing unmapped reads (bitwise flag 4) and secondary/shorter-chimeric-product reads (bitwise flag 256 -- note that using 256 removes both 256 and 272, reverse reads that are also secondary alignments/shorter-chimeric-products)
zcat $baseFile1.QCed.sam.gz | /home/shared/software/samtools/samtools-0.1.19/samtools view -q 10 -F 4 -F 256 -bSu - | /home/shared/software/samtools/samtools-0.1.18/samtools sort -o - samtools_csort_tmp_$baseFile > $baseFile1.QCed.preGATK.QCed.bam
/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFile1.QCed.preGATK.QCed.bam $baseFile1.QCed.preGATK.QCed.bai

averageReadLengthpreQCFull=`zcat $baseFile1.QCed.sam.gz | perl -lane 'if ($F[0] !~ /^@/) { my @vals1 = split(//, $F[9]); $reads += scalar(@vals1); $count++; } if (eof()) { print $reads, "\t", $count, "\t", $reads/$count ; }'`
averageReadLengthpreQC=`echo $averageReadLengthpreQCFull | awk '{ print $3 }'`
averageReadLengthpostQCFull=`samtools view $baseFile1.QCed.preGATK.QCed.bam | perl -lane 'if ($F[0] !~ /^@/) { my @vals1 = split(//, $F[9]); $reads += scalar(@vals1); $count++; } if (eof()) { print $reads, "\t", $count, "\t", $reads/$count ; }'`
averageReadLengthpostQC=`echo $averageReadLengthpostQCFull | awk '{ print $3 }'`
totalReadsAboveQ10=`zcat $baseFile1.QCed.sam.gz | samtools view -q 10 -S -c -`
totalReadsQ10=`printf "%.0f" $(echo "$totalReadsPreQC - $totalReadsAboveQ10" | bc)`
totalReadsQ10Percent=`printf "%.4f" $(echo "$totalReadsQ10/$totalReadsPreQC" | bc -l)`
totalReadsF4=`zcat $baseFile1.QCed.sam.gz | samtools view -f 4 -S -c -`
totalReadsF4Percent=`printf "%.4f" $(echo "$totalReadsF4/$totalReadsPreQC" | bc -l)`
totalReadsF256=`zcat $baseFile1.QCed.sam.gz | samtools view -f 256 -S -c -`
totalReadsF256Percent=`printf "%.4f" $(echo "$totalReadsF256/$totalReadsPreQC" | bc -l)`
totalReadsPostQC=`samtools view -c $baseFile1.QCed.preGATK.QCed.bam`
totalReadsDropped=`printf "%.0f" $(echo "$totalReadsPreQC - $totalReadsPostQC" | bc )`
totalReadsDroppedPercent=`printf "%.4f" $(echo "$totalReadsDropped/$totalReadsPreQC" | bc -l)`
coverageBedFilePostQCFull=`samtools depth -b /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed $baseFile1.QCed.preGATK.QCed.bam | perl -lane '$sum += $F[2]; $count1++; if (eof()) { print $sum, "\t", $count1, "\t", $sum/$count1; } '`
coverageBedFilePostQC=`echo $coverageBedFilePostQCFull | awk '{ print $3 }'`

echo $POOLID $baseFile1 $totalReadsPreQC $totalReadsQ10 $totalReadsQ10Percent $totalReadsF4 $totalReadsF4Percent $totalReadsF256 $totalReadsF256Percent $totalReadsPostQC $totalReadsDropped $totalReadsDroppedPercent $averageReadLengthpreQC $averageReadLengthpostQC $coverageBedFilePostQC | perl -lane 'print "$F[0] $F[1] TotalReadsPreQC: $F[2] TotalReadsQ10(%): $F[3] $F[4] TotalReadsF4(%): $F[5] $F[6] TotalReadsF256(%): $F[7] $F[8] TotalReadsPostQC: $F[9] TotalReadsDropped(%): $F[10] $F[11] AverageReadLengthPreQC: $F[12] AverageReadLengthPostQC: $F[13] BedFileCoveragePostQC: $F[14]";' > $baseFile1.QCed.preGATK.QCed.bam.stats 

date | xargs echo "Post initial samtools timepoint:"

mv /tmp/$PBS_JOBID/$baseFile1.*sam* /tmp/$PBS_JOBID/$baseFile1.*preGATK* $mainDir1/. 

rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
