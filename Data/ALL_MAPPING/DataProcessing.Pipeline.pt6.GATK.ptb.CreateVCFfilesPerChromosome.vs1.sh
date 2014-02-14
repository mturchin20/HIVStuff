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

#/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T UnifiedGenotyper -R $refFile1 -I ${mainDir1}/${baseFileN}.Chr${I}.ReduceReads.bam -L ${I} -ploidy 2 -glm BOTH -stand_call_conf 30 -stand_emit_conf 10 -o ${baseFileN}.Chr${I}.GATK.ReduceReads.raw.vcf 

/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T UnifiedGenotyper -R $refFile1 -I ${mainDir1}/${baseFileN}.Chr${I}.ReduceReads.bam -L ${I} --dbsnp /home/michaelt/Software/GATK/2.5.2/resources/dbsnp_137.b37.vcf -stand_call_conf 50 -stand_emit_conf 10 -dcov 250 -glm BOTH -nct 6 -o ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.raw.vcf 

#java -jar GenomeAnalysisTK.jar \
#   -R resources/Homo_sapiens_assembly18.fasta \
#      -T UnifiedGenotyper \
#         -I sample1.bam [-I sample2.bam ...] \
#	    --dbsnp dbSNP.vcf \
#	       -o snps.raw.vcf \
#	          -stand_call_conf [50.0] \
#		     -stand_emit_conf 10.0 \
#		        -dcov [50 for 4x, 200 for >30x WGS or Whole exome] \

gzip ${baseFileN}.Chr${I}.GATK.ReduceReads.UG.raw.vcf

mv /tmp/$PBS_JOBID/$baseFileN* $mainDir1/GATK/. 

rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
