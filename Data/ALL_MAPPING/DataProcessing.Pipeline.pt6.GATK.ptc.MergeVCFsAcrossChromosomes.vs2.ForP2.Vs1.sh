#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`

vcf-concat AllPools.P2.Vs1.AllPoolsMerged.Chr1.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr2.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr3.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr4.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr5.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr6.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr7.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr8.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr9.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr10.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr11.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr13.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr14.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr15.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr16.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr17.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr18.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr19.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr20.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr21.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.Chr22.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.P2.Vs1.AllPoolsMerged.ChrX.GATK.ReduceReads.UG.raw.vcf.gz > AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.raw.vcf

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
