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
echo "Working variables:" $mainDir1 $baseFile1 $refFileFlag1 $mergeFlag1
echo ""

#Variables: $mainDir1, $MergeListbam1, $MergeListbai1, $refFileFlag
refFile1=""
refFile2="/tmp/$PBS_JOBID/human_g1k_v37.fasta"

#baseFiles no longer exist -- turned into the MergeListbam1 and MergeListbai1 shoud be able to just cp -p $MergeListbam1 . for ex. and cp -p $MergeListbai1 -- make POOLID (if not passed already be sure to pass it) the baseFile ID thing to replace baseFileN with and track to the /SampleData/SampleDirectories/.

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
	echo "Error1 - refFileFlag1 $refFileFlag1 does not contain an expected version number (0-9) for bwa's reference files"
fi

cp -p $refFile1* /tmp/$PBS_JOBID/.
refFile1dict=`echo $refFile1 | perl -ane 'if ($F[0] =~ m/(.*)(fasta)/) { print $1 . "dict"; }'`
cp -p $refFile1dict /tmp/$PBS_JOBID/.

#baseFile2=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "02" . $3; } '`
#baseFileN=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "0N" . $3; } '`
baseFile= 		#JOBID thing here now?

cp -p $mainDir1/$baseFile1.preGATK.bam /tmp/$PBS_JOBID/.
cp -p $mainDir1/$baseFile2.preGATK.bam /tmp/$PBS_JOBID/.
	
date | xargs echo "Pre GATK/picard/samtools cleanup timepoint:"

#/home/shared/software/samtools/samtools-0.1.19/samtools merge $baseFile1.preGATK.bam $baseFile2.preGATK.bam 
#For loop in perl with variable containing as many 'I=filefilefile' designations as possible and just do ...MergeSamFiles.jar $ThatVariable O=$baseFileN.preGATK.bam
java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MergeSamFiles.jar I=$baseFile1.preGATK.bam I=$baseFile2.preGATK.bam O=$baseFileN.preGATK.bam

java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MarkDuplicates.jar I=$baseFileN.preGATK.bam O=$baseFileN.GATK.rmdup.bam REMOVE_DUPLICATES=TRUE

java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T BaseRecalibrator -I $baseFileN.GATK.rmdup.bam -R $refFile2 -knownSites /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf -o $baseFileN.GATK.rmdup.grp
java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T PrintReads -R $refFile2 -I $baseFileN.GATK.rmdup.bam -BQSR $baseFileN.GATK.rmdup.grp -o $baseFileN.GATK.rmdup.BQSR.bam
	
/home/shared/software/samtools/samtools-0.1.19/samtools calmd -b $baseFileN.GATK.rmdup.BQSR.bam $refFile2 > $baseFileN.GATK.rmdup.BQSR.calmd.bam 

/home/shared/software/samtools/samtools-0.1.19/samtools view -b -q 30 $baseFileN.GATK.rmdup.BQSR.calmd.bam > $baseFileN.GATK.rmdup.BQSR.calmd.qTrsh30.bam #Optional? -- Use, maybe -q 10 based on other people's use seen online? Unsure which is more appropriate -- look at a few example bams and compare -q 10 with -q 30
/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFileN.GATK.rmdup.BQSR.calmd.qTrsh30.bam $baseFileN.GATK.rmdup.BQSR.calmd.qTrsh30.bai

date | xargs echo "Post GATK/picard/samtools cleanup timepoint:"

#Do a coverage type estimate at this point / here? To get overall coverage statistic information for the individual?

#Drop reads that do not uniquely map? this will be taken care of by the mapq cutoff option of samtools view -q ## in earlier step
#Drop reads that do not map to expected target regions?

mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/. 

rm -r /tmp/$PBS_JOBID

#alias this at some point?
#/home/shared/software/bwa/bwa-0.7.4/bwa mem $refVrs $baseFile1.fastq | gzip > $baseFile1.sam.gz
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
