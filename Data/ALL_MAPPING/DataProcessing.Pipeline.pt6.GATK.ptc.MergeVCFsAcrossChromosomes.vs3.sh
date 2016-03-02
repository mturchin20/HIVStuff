#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged
#baseFile1 Ex: AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

mainDir1="$1"
baseFile1="$2"

vcf-concat ${mainDir1}/${baseFile1}.Chr1.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr2.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr3.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr4.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr5.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr6.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr7.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr8.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr9.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr10.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr11.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr12.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr13.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr14.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr15.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr16.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr17.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr18.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr19.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr20.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr21.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.Chr22.GATK.ReduceReads.UG.raw.vcf.gz \
${mainDir1}/${baseFile1}.ChrX.GATK.ReduceReads.UG.raw.vcf.gz > ${mainDir1}/${baseFile1}.ChrAll.GATK.ReduceReads.UG.raw.vcf

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
