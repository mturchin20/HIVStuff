#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged
#baseFile1 Ex: AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

mainDir1="$1"
baseFile1="$2"

cat $mainDir1/${baseFile1}.Chr1.C50.flt.ped \
$mainDir1/${baseFile1}.Chr2.C50.flt.ped \
$mainDir1/${baseFile1}.Chr3.C50.flt.ped \
$mainDir1/${baseFile1}.Chr4.C50.flt.ped \
$mainDir1/${baseFile1}.Chr5.C50.flt.ped \
$mainDir1/${baseFile1}.Chr6.C50.flt.ped \
$mainDir1/${baseFile1}.Chr7.C50.flt.ped \
$mainDir1/${baseFile1}.Chr8.C50.flt.ped \
$mainDir1/${baseFile1}.Chr9.C50.flt.ped \
$mainDir1/${baseFile1}.Chr10.C50.flt.ped \
$mainDir1/${baseFile1}.Chr11.C50.flt.ped \
$mainDir1/${baseFile1}.Chr12.C50.flt.ped \
$mainDir1/${baseFile1}.Chr13.C50.flt.ped \
$mainDir1/${baseFile1}.Chr14.C50.flt.ped \
$mainDir1/${baseFile1}.Chr15.C50.flt.ped \
$mainDir1/${baseFile1}.Chr16.C50.flt.ped \
$mainDir1/${baseFile1}.Chr17.C50.flt.ped \
$mainDir1/${baseFile1}.Chr18.C50.flt.ped \
$mainDir1/${baseFile1}.Chr19.C50.flt.ped \
$mainDir1/${baseFile1}.Chr20.C50.flt.ped \
$mainDir1/${baseFile1}.Chr21.C50.flt.ped \
$mainDir1/${baseFile1}.Chr22.C50.flt.ped \
$mainDir1/${baseFile1}.ChrX.C50.flt.ped > $mainDir1/${baseFile1}.ChrAll.C50.flt.ped

cat $mainDir1/${baseFile1}.Chr1.C50.flt.map \
$mainDir1/${baseFile1}.Chr2.C50.flt.map \
$mainDir1/${baseFile1}.Chr3.C50.flt.map \
$mainDir1/${baseFile1}.Chr4.C50.flt.map \
$mainDir1/${baseFile1}.Chr5.C50.flt.map \
$mainDir1/${baseFile1}.Chr6.C50.flt.map \
$mainDir1/${baseFile1}.Chr7.C50.flt.map \
$mainDir1/${baseFile1}.Chr8.C50.flt.map \
$mainDir1/${baseFile1}.Chr9.C50.flt.map \
$mainDir1/${baseFile1}.Chr10.C50.flt.map \
$mainDir1/${baseFile1}.Chr11.C50.flt.map \
$mainDir1/${baseFile1}.Chr12.C50.flt.map \
$mainDir1/${baseFile1}.Chr13.C50.flt.map \
$mainDir1/${baseFile1}.Chr14.C50.flt.map \
$mainDir1/${baseFile1}.Chr15.C50.flt.map \
$mainDir1/${baseFile1}.Chr16.C50.flt.map \
$mainDir1/${baseFile1}.Chr17.C50.flt.map \
$mainDir1/${baseFile1}.Chr18.C50.flt.map \
$mainDir1/${baseFile1}.Chr19.C50.flt.map \
$mainDir1/${baseFile1}.Chr20.C50.flt.map \
$mainDir1/${baseFile1}.Chr21.C50.flt.map \
$mainDir1/${baseFile1}.Chr22.C50.flt.map \
$mainDir1/${baseFile1}.ChrX.C50.flt.map > $mainDir1/${baseFile1}.ChrAll.C50.flt.map

plink --file $mainDir1/${baseFile1}.ChrAll.C50.flt --make-bed --out $mainDir1/${baseFile1}.ChrAll.C50.flt

