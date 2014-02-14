#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged
#baseFile1 Ex: AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

mainDir1="$1"
baseFile1="$2"

plink --file $mainDir1/${baseFile1}.Chr1.C50.flt --merge-list DataProcessing.Pipeline.pt6.All.ptc.CollapsePedFilesIntoSingleFile.vs2.List  --make-bed --out $mainDir1/${baseFile1}.ChrAll.C50.flt

