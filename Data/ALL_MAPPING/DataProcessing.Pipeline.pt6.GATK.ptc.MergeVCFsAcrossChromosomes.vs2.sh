#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`

vcf-concat AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr1.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr2.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr3.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr4.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr5.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr6.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr7.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr8.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr9.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr10.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr11.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr13.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr14.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr15.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr16.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr17.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr18.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr19.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr20.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr21.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr22.GATK.ReduceReads.UG.raw.vcf.gz \
AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrX.GATK.ReduceReads.UG.raw.vcf.gz > AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.raw.vcf

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
