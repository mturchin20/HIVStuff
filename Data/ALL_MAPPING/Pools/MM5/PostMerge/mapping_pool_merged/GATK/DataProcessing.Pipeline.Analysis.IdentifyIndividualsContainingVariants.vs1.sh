#!/bin/sh

#Ex File1: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SpecificGenes/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.Exonic.KIAA1429.PP2_PD.Locations

ChrN="$1"
File1="$2"

OLD_IFS="$IFS" 
IFS=$'\n'

for BP1Full in `cat $File1`
do

	IFS=$OLD_IFS
	
	BP1=`echo $BP1Full | awk '{ print $1 }'`
	PP2_Class=`echo $BP1Full | awk '{ print $2 }'`

	zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk -v ChrN=$ChrN '{ if ($1 == ChrN) { print $0 } } ' | grep $BP1 | perl -sane 'print $bp1, "(", $pp2_Class, "): "; for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";' -- -bp1=$BP1 -pp2_Class=$PP2_Class

done


