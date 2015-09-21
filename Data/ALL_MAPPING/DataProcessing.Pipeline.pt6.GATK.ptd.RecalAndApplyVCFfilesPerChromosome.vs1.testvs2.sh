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

refFile1=""

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

#/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T VariantRecalibrator -R $refFile1 -input $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.raw.gz -recalFile ${baseFileN}.Chr${I}.GATK.ReduceReads.raw.recal -tranchesFile ${baseFileN}.Chr${I}.GATK.ReduceReads.raw.tranches -nt 4 --numBadVariants 1000 -resource:hapmap,known=false,training=true,truth=true,prior=15.0 /home/michaelt/Software/GATK/2.5.2/resources/hapmap_3.3.b37.vcf -resource:omni,known=false,training=true,truth=true,prior=12.0 /home/michaelt/Software/GATK/2.5.2/resources/1000G_omni2.5.b37.vcf -resource:1000G,known=false,training=true,truth=false,prior=10.0 /home/michaelt/Software/GATK/2.5.2/resources/1000G_phase1.snps.high_confidence.b37.vcf -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf -an QD -an MQRankSum -an ReadPosRankSum -an FS -an DP -an HaplotypeScore -mode SNP

/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T VariantAnnotator -R $refFile1 -I $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.bam -o $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.UG.HRun.raw.vcf -A HomopolymerRun --variant $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.UG.raw.vcf

/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T VariantRecalibrator -R $refFile1 -input $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.UG.raw.vcf -recalFile ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.recal -tranchesFile ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.tranches -nt 4 -percentBad .01 -minNumBad 1000 -resource:hapmap,known=false,training=true,truth=true,prior=15.0 /home/michaelt/Software/GATK/2.5.2/resources/hapmap_3.3.b37.vcf -resource:omni,known=false,training=true,truth=true,prior=12.0 /home/michaelt/Software/GATK/2.5.2/resources/1000G_omni2.5.b37.vcf -resource:1000G,known=false,training=true,truth=false,prior=10.0 /home/michaelt/Software/GATK/2.5.2/resources/1000G_phase1.snps.high_confidence.b37.vcf -resource:dbsnp,known=true,training=false,truth=false,prior=2.0 /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.excluding_sites_after_129.vcf -an QD -an MQRankSum -an ReadPosRankSum -an FS -an DP -an HaplotypeScore -an HRun -tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 -mode SNP

/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T ApplyRecalibration -R $refFile1 -input $mainDir1/${baseFileN}.Chr${I}.GATK.ReduceReads.UG.raw.vcf -recalFile ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.recal -tranchesFile ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.tranches -o ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.SNP.vcf --ts_filter_level 99.9 -mode SNP

#java -Xmx3g -jar GenomeAnalysisTK.jar \
#   -T ApplyRecalibration \
#      -R reference/human_g1k_v37.fasta \
#         -input raw.input.vcf \
#	    -tranchesFile path/to/input.tranches \
#	       -recalFile path/to/input.recal \
#	          -o path/to/output.recalibrated.filtered.vcf \


#gzip ${baseFileN}.Chr${I}.GATK.ReduceReads.raw.run2.vc
gzip ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.VQSR.SNP.vcf

#mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/GATK/. 
mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/. 

rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
