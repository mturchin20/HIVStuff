#!/bin/sh

#######
#
#	Description
#	
#	Note 20130522: mergeFlag1 is never expected to equal 1 now; code is being kept there for the time being to maintain a physical record of the thought process/logic at that time. A separate script is being created that will perform the same functions, collecting /all/ .bam files present in the directory on the per individual level, rather than explicitly just combining the two PTP regions across the single plate/run (e.g. if two separate runs were done or an individual, collect all .bams from all sections of the PTPs for each run and then do the aggregate MarkDup/BQSR steps. Using Pool##_RL## as the sample full/true name)
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
echo "Working variables:" $mainDir1 $baseFileN $refFileFlag1
echo ""

#Variables: $mainDir1, $baseFileN, $refFileFlag1
refFile1=""
refFile2="/tmp/$PBS_JOBID/human_g1k_v37.fasta"

#baseFiles no longer exist -- turned into the MergeListbam1 and MergeListbai1 shoud be able to just cp -p $MergeListbam1 . for ex. and cp -p $MergeListbai1 -- make POOLID (if not passed already be sure to pass it) the baseFile ID thing to replace baseFileN with and track to the /SampleData/SampleDirectories/.

###mkdir /tmp/$PBS_JOBID
###cd /tmp/$PBS_JOBID

cd $mainDir1

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

#cp -p $refFile1* /tmp/$PBS_JOBID/.
refFile1dict=`echo $refFile1 | perl -ane 'if ($F[0] =~ m/(.*)(fasta)/) { print $1 . "dict"; }'`
#cp -p $refFile1dict /tmp/$PBS_JOBID/.
#cp -p /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf /home/michaelt/Software/GATK/2.5.2/resources/Mills_and_1000G_gold_standard.indels.b37.vcf /home/michaelt/Software/GATK/2.5.2/resources/1000G_phase1.indels.b37.vcf /tmp/$PBS_JOBID/.
refFile2=$refFile1

#baseFileN=`echo $mainDir1 | perl -F/ -ane 'print $F[9];'`
POOLID=`echo $baseFileN | perl -ane 'if ($F[0] =~ m/(POOL_P2_[0-9]+.*\d\dRL).*/) { print $1; } '`

###cp -p $mainDir1/$baseFileN.QCed.preGATK.QCed.samplesMerged.bam /tmp/$PBS_JOBID/.
	
date | xargs echo "MarkDuplicates pre-timepoint:"

numFiles=`samtools view -H $baseFileN.QCed.preGATK.QCed.samplesMerged.bam | grep ID | wc | awk '{ print $1 }'` 
totalReadsPreQC=`samtools view -c $baseFileN.QCed.preGATK.QCed.samplesMerged.bam`
totalReadsPreQCFoward=`samtools view -c -F 16 $baseFileN.QCed.preGATK.QCed.samplesMerged.bam`
totalReadsPreQCReverse=`samtools view -c -f 16 $baseFileN.QCed.preGATK.QCed.samplesMerged.bam`
totalReadsPreQCForwardReverseRatio=`printf "%.4f" $(echo "$totalReadsPreQCFoward/$totalReadsPreQCReverse" | bc -l)`
readLengthInfoStatisticsAndAvgMAPQPreQC=`samtools view $baseFileN.QCed.preGATK.QCed.samplesMerged.bam | perl -ane 'push(@mapQ, $F[4]); push(@readLengths, scalar(split(//, $F[9]))); $totalReads++; if (eof()) { use Statistics::Descriptive; $stat1 = Statistics::Descriptive::Full->new(); $stat1->add_data(@readLengths); $stat2 = Statistics::Descriptive::Full->new(); $stat2->add_data(@mapQ); print "PreQCMAPQmean: ", $stat2->mean(), " PreQCMAPQsd: ", $stat2->standard_deviation(), " PreQCMean: ", $stat1->mean(), " PreQCSD: ", $stat1->standard_deviation(), " PreQCMax: ", $stat1->max(), " PreQCMin: ", $stat1->min(); }'` 
coverageBedFilePreQCFull=`samtools depth -b /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.altrd.bed $baseFileN.QCed.preGATK.QCed.samplesMerged.bam | perl -lane '$sum += $F[2]; $count1++; if (eof()) { print $sum, "\t", $count1, "\t", $sum/$count1; } '`
coverageBedFilePreQC=`echo $coverageBedFilePreQCFull | awk '{ print $3 }'`

###/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MarkDuplicates.jar I=$baseFileN.QCed.preGATK.QCed.samplesMerged.bam M=$baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.PicardStats O=$baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bam REMOVE_DUPLICATES=TRUE
###/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bam $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bai

totalReadsPostRemoveDuplicates=`samtools view -c $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bam`
totalReadsPostRemoveDuplicatesDropped=`printf "%.0f" $(echo "$totalReadsPreQC - $totalReadsPostRemoveDuplicates" | bc )`
totalReadsPostRemoveDuplicatesDroppedPercent=`printf "%.4f" $(echo "$totalReadsPostRemoveDuplicatesDropped/$totalReadsPreQC" | bc -l)`

date | xargs echo "GATK BQSR pre-timepoint:"

###/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T BaseRecalibrator -I $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bam -R $refFile2 -knownSites /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf -knownSites /home/michaelt/Software/GATK/2.5.2/resources/Mills_and_1000G_gold_standard.indels.b37.vcf -knownSites /home/michaelt/Software/GATK/2.5.2/resources/1000G_phase1.indels.b37.vcf -o $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.grp

###/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T PrintReads -R $refFile2 -I $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.bam -BQSR $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.grp -o $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.bam

date | xargs echo "samtools wrap-up pre-timepoint:"
	
###/home/shared/software/samtools/samtools-0.1.19/samtools calmd -b $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.bam $refFile2 > $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam 

###/home/shared/software/samtools/samtools-0.1.19/samtools index $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bai

totalReadsPostQC=`samtools view -c $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam`
totalReadsPostQCFoward=`samtools view -c -F 16 $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam`
totalReadsPostQCReverse=`samtools view -c -f 16 $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam`
totalReadsPostQCForwardReverseRatio=`printf "%.4f" $(echo "$totalReadsPostQCFoward/$totalReadsPostQCReverse" | bc -l)`
readLengthInfoStatisticsAndAvgMAPQPostQC=`samtools view $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam | perl -ane 'push(@mapQ, $F[4]); push(@readLengths, scalar(split(//, $F[9]))); $totalReads++; if (eof()) { use Statistics::Descriptive; $stat1 = Statistics::Descriptive::Full->new(); $stat1->add_data(@readLengths); $stat2 = Statistics::Descriptive::Full->new(); $stat2->add_data(@mapQ); print "PostQCMAPQmean: ", $stat2->mean(), " PostQCMAPQsd: ", $stat2->standard_deviation(), " PostQCMean: ", $stat1->mean(), " PostQCSD: ", $stat1->standard_deviation(), " PostQCMax: ", $stat1->max(), " PostQCMin: ", $stat1->min(); }'` 
coverageBedFilePostQCFull=`samtools depth -b /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.altrd.bed $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam | perl -lane '$sum += $F[2]; $count1++; if (eof()) { print $sum, "\t", $count1, "\t", $sum/$count1; } '`
coverageBedFilePostQC=`echo $coverageBedFilePostQCFull | awk '{ print $3 }'`

#Do a coverage type estimate at this point / here? To get overall coverage statistic information for the individual?
#/home/shared/software/java/jre1.7.0_09/bin/java -Xmx2g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T DepthOfCoverage -R $refFile2 -I GATK.samplesMerged.rmdup.BQSR.calmd.bam -o $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats #/very/ long runtime, potentially unnecessary; run on finally, merged bam file across all individuals??
#/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/CollectAlignmentSummaryMetrics.jar INPUT=$baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam OUTPUT=$baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats.Picard REFERENCE_SEQUENCE=$refFile2

echo $POOLID $numFiles $totalReadsPreQC $totalReadsPreQCFoward $totalReadsPreQCReverse $totalReadsPreQCForwardReverseRatio $readLengthInfoStatisticsAndAvgMAPQPreQC $coverageBedFilePreQC $totalReadsPostRemoveDuplicates $totalReadsPostRemoveDuplicatesDropped $totalReadsPostRemoveDuplicatesDroppedPercent $totalReadsPostQC $totalReadsPostQCFoward $totalReadsPostQCReverse $totalReadsPostQCForwardReverseRatio $readLengthInfoStatisticsAndAvgMAPQPostQC $coverageBedFilePostQC | perl -lane 'print "ID: $F[0] NumberOfOriginalBamFiles: $F[1] TotalReadsPreQC: $F[2] TotalReadsPreQCForward: $F[3] TotalReadsPreQCReverse: $F[4] TotalReadsPreQCForward/Reverse: $F[5] ", join(" ", @F[6..17])," CoveragePreQC: $F[18] TotalReadsPostRmdup: $F[19] TotalReadsPostRmdupDropped: $F[20] TotalReadsPostRmdupDroppedPercentage: $F[21] TotalReadsPostQC: $F[22] TotalReadsPostQCForward: $F[23] TotalReadsPostQCReverse: $F[24] TotalReadsPostQCForward/Reverse: $F[25] ", join(" ", @F[26..37]), " CoveragePostQC: $F[38]"' > $baseFileN.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats 

#Drop reads that do not map to expected target regions?

###rm $baseFileN.QCed.preGATK.QCed.samplesMerged.bam
###mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/. 

###rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
