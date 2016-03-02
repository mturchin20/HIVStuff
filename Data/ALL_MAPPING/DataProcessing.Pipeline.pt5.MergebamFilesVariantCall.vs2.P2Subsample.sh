#!/bin/sh

#######
#
#	Description
#	
#
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
#PBSnodeFile=`cat $PBS_NODEFILE`
#PBSnodeFile=`cat $PBS_NODEFILE`
#echo ""
#echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
#echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBS_NODEFILE} ~~"
#echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
#echo "Working variables:" $mainDir1 $mergeFileList1
#echo ""

#Variables: $mainDir1, $mergeFileList1

#Example: DataOrganization.CreatebamMergeList.vs1.20130909_231450.output 
mainDir1="$1"
mergeFileList1="$2"

echo $mainDir1 $mergeFileList1

refFileFlag1=`perl -e 'my $val1 = int(rand(9)); print $val1;'`
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

#cat $mergeFileList1 | perl -F/\;/ -lane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); $vals2[7] = "PostMerge"; if ($vals2[9] =~ m/(POOL\d+).*(\d\dRL)/) { $vals2[$#vals2] = $1 . "_" . $2; my $dir1 = join("/", @vals2); system(" ls -lrt $dir1 | wc");}'

#if [ ! -e ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam ] ; then

	echo "blah"

#	mergeBamCommand1=`cat $mergeFileList1 | perl -F/\;/ -lane 'my @vals1 = split(/\|/, $F[0]); $vals1[7] = "PostMerge"; if ($vals1[9] =~ m/(POOL\d+).*(\d\dRL)/) { $F[vals1] = $1 . "_" . $2;  print "I=/", join("/", @vals1[1..9]), "/", $vals1[9], ".QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.bam\t";}'`
	mergeBamCommand1=`cat $mergeFileList1 | perl -F/\;/ -lane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); $vals2[9] = "PostMerge"; if ($vals2[11] =~ m/(POOL\w+).*(\d\dRL)/) { $vals2[$#vals2] = $1 . "_" . $2;  print "I=/", join("/", @vals2[1..11]), "/P2Subsample/", $vals2[11], ".QCed.preGATK.QCed.samplesMerged.P2Subsample25.rmdup.BQSR.calmd.bam\t";}'`

	echo $mergeBamCommand1

	/home/shared/software/java/jre1.7.0_09/bin/java -Xmx50g -jar /home/shared/software/picard/picard-tools-1.91/MergeSamFiles.jar $mergeBamCommand1 O=${mainDir1}/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.P2Subsample75.rmdup.BQSR.calmd.AllPoolsMerged.bam USE_THREADING=TRUE SORT_ORDER=coordinate

	/home/shared/software/samtools/samtools-0.1.19/samtools index ${mainDir1}/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.P2Subsample75.rmdup.BQSR.calmd.AllPoolsMerged.bam ${mainDir1}/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.P2Subsample75.rmdup.BQSR.calmd.AllPoolsMerged.bai

	

#	/home/shared/software/java/jre1.7.0_09/bin/java -Xmx50g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -R $refFile1 -T ReduceReads -I ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam -o ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ReduceReads.bam

#fi
	
#/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -R $refFile1 -T ReduceReads -I ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam -o ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ReduceReads.bam

#/home/shared/software/samtools/samtools-0.1.19/samtools mpileup -uf $refFile1 ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam | /home/shared/software/samtools/samtools-0.1.19/bcftools/bcftools view -bvcg - > ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.raw.bcf  
#/home/shared/software/samtools/samtools-0.1.19/samtools mpileup -u -r 2:100,000-150,000  -f $refFile1 ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam | /home/shared/software/samtools/samtools-0.1.19/bcftools/bcftools view -bvcg - > ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.raw.bcf  

#/home/shared/software/samtools/samtools-0.1.19/bcftools/bcftools view ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.raw.bcf | perl /home/shared/software/samtools/samtools-0.1.19/bcftools/vcfutils.pl varFilter -D100 > ${mainDir1}/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.flt.vcf  



endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
