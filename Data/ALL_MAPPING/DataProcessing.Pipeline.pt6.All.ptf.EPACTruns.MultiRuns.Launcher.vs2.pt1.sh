#!/bin/sh

#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#vcf1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.vcf.bgzip.gz
#groupf1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.GroupFile
#ped1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped
#out1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.EPACTS

mainDir1="$1"
vcf1="$2"
groupf1="$3"
ped1="$4"
out1="$5"

if [ ! -d ${mainDir1}/qsubout ] ; then
	mkdir ${mainDir1}/qsubout
fi

qsubout="${mainDir1}/qsubout/qsubout.EPACTSruns.MultiRuns.Launcher.vs2.txt"
#qsubouttemp="${mainDir1}/qsubout/qsubout.EPACTSruns.MultiRuns.Launcher.vs2.txt_temp"
#qsuboutAll="${mainDir1}/qsubout/qsubout.All.EPACTSruns.MultiRuns.Launcher.vs2.txt"
#qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.EPACTSruns.MultiRuns.Launcher.vs2.txt_temp"
#
#if [ -e $qsubout ] ; then
#	if [ -e $qsuboutAll ] ; then
#		appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
#	
#		echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
#		mv $qsuboutAlltemp $qsuboutAll
#	else 
#		echo "Append_1" | cat - $qsubout > $qsuboutAll
#	fi
#fi

echo $qsubout

#groupfCommandExonicNon="Exonic.Nonsynonymous"
###groupfCommandExonicNon="Exonic.Nonsynonymous.wSplice"
groupfCommandExonicNon="Intronic"

#echo $groupfCommandAll

for i in {2..100} 
do

	bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.MultiRuns.Launcher.vs3.pt2.sh $mainDir1 $vcf1 $groupf1 $groupfCommandExonicNon $ped1 $out1 $i

	sleep 1

done

