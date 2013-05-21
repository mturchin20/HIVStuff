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
echo "Working variables:" $mainDir1 $baseFile1 $refFileFlag1 $mergeFlag1
echo ""

#Variables: $mainDir1, $baseFile1, $refFileFlag1, $mergeFlag1
refFile1=""
refFile2="/tmp/$PBS_JOBID/human_g1k_v37.fasta"

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

if [ $mergeFlag1 == 0 ] ; then

	date | xargs echo "Pre bwa timepoint:"
	
	/home/shared/software/bwa/bwa-0.7.4/bwa mem -M $refFile1 $baseFile1.QCed.fastq.gz | gzip > $baseFile1.QCed.sam.gz
	
	date | xargs echo "Post bwa timepoint:"
	
	zcat $baseFile1.QCed.sam.gz | /home/shared/software/samtools/samtools-0.1.19/samtools view -bSu - | /home/shared/software/samtools/samtools-0.1.18/samtools sort -o - samtools_csort_tmp_$baseFile > $baseFile1.QCed.preGATK.bam
	/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFile1.QCed.preGATK.bam $baseFile1.QCed.preGATK.bai

	date | xargs echo "Post initial samtools timepoint:"

elif [ $mergeFlag1 == 1 ] ; then

	baseFile2=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "02" . $3; } '`
	baseFileN=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "0N" . $3; } '`
	
	date | xargs echo "Pre GATK/picard/samtools cleanup timepoint:"

#	/home/shared/software/samtools/samtools-0.1.19/samtools merge $baseFile1.QCed.preGATK.bam $baseFile2.QCed.preGATK.bam
	java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MergeSamFiles.jar I=$baseFile1.QCed.preGATK.bam I=$baseFile2.QCed.preGATK.bam O=$baseFileN.QCed.preGATK.bam

	java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MarkDuplicates.jar I=$baseFileN.QCed.preGATK.bam O=$baseFileN.QCed.GATK.rmdup.bam REMOVE_DUPLICATES=TRUE

	java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T BaseReaclibrator -I $baseFileN.QCed.GATK.rmdup.bam -R $refFile1 -knownSites /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf -o $baseFileN.QCed.GATK.rmdup.grp
	java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T PrintReads -R $refFile1 -I $baseFileN.QCed.GATK.rmdup.bam -BQSR $baseFileN.QCed.GATK.rmdup.grp -o $baseFileN.QCed.GATK.rmdup.BQSR.bam
	
	/home/shared/software/samtools/samtools-0.1.19/samtools calmd -b $baseFileN.QCed.GATK.rmdup.BQSR.bam $refFile1 > $baseFileN.QCed.GATK.rmdup.BQSR.calmd.bam 

	/home/shared/software/samtools/samtools-0.1.19/samtools view -b -q 30 $baseFileN.QCed.GATK.rmdup.BQSR.calmd.bam > $baseFileN.QCed.GATK.rmdup.BQSR.calmd.qTrsh30.bam #Optional?
	/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFileN.QCed.GATK.rmdup.BQSR.calmd.qTrsh30.bam $baseFileN.QCed.GATK.rmdup.BQSR.calmd.qTrsh30.bai

	date | xargs echo "Post GATK/picard/samtools cleanup timepoint:"

	#Drop reads that do not uniquely map?
	#Drop reads that do not map to expected target regions?


else
	echo "Error2 - mergeFlag1 $mergeFlag1 is neither 0 or 1"
fi




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
