#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#vcf1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.vcf.bgzip.gz
#groupf1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.GroupFile
#groupfSpecific Ex: Exonic.Nonsynonymous
#ped1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped
#out1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.EPACTS
#runNum1 Ex: 1

mainDir1="$1"
vcf1="$2"
groupf1="$3"
groupfSpecific="$4"
ped1="$5"
out1="$6"
runNum1="$7"

if [ ! -d ${mainDir1}/qsubout ] ; then
	mkdir ${mainDir1}/qsubout
fi

#qsubout="${mainDir1}/qsubout/qsubout.EPACTSruns.MultiRuns.Launcher.vs2.pt2"
#qsubouttemp="${mainDir1}/qsubout/qsubout.EPACTSruns.MultiRuns.Launcher.vs2.pt2_temp"
#qsuboutAll="${mainDir1}/qsubout/qsubout.All.EPACTSruns.MultiRuns.Launcher.vs2.pt2"
#qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.EPACTSruns.MultiRuns.Launcher.vs2.pt2_temp"
qsubout1="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat0.run${runNum1}"
qsubout1temp="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat0.run${runNum1}_temp"
qsubout1All="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat0.run${runNum1}"
qsubout1Alltemp="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat0.run${runNum1}_temp"
if [ -e $qsubout1 ] ; then
	if [ -e $qsubout1All ] ; then
		appendCheckValue=`cat $qsubout1All | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
		
		echo $appendCheckValue | cat $qsubout1All - $qsubout1 > $qsubout1Alltemp
		mv $qsubout1Alltemp $qsubout1All
	else 
		echo "Append_1" | cat - $qsubout1 > $qsubout1All
	fi
fi
qsubout2="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat0.run${runNum1}"
qsubout2temp="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat0.run${runNum1}_temp"
qsubout2All="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat0.run${runNum1}"
qsubout2Alltemp="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat0.run${runNum1}_temp"
if [ -e $qsubout2 ] ; then
	if [ -e $qsubout2All ] ; then
		appendCheckValue=`cat $qsubout2All | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
		
		echo $appendCheckValue | cat $qsubout2All - $qsubout2 > $qsubout2Alltemp
		mv $qsubout2Alltemp $qsubout2All
	else 
		echo "Append_1" | cat - $qsubout2 > $qsubout2All
	fi
fi
qsubout3="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1}"
qsubout3temp="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1}_temp"
qsubout3All="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1}"
qsubout3Alltemp="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1}_temp"
if [ -e $qsubout3 ] ; then
	if [ -e $qsubout3All ] ; then
		appendCheckValue=`cat $qsubout3All | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
		
		echo $appendCheckValue | cat $qsubout3All - $qsubout3 > $qsubout3Alltemp
		mv $qsubout3Alltemp $qsubout3All
	else 
		echo "Append_1" | cat - $qsubout3 > $qsubout3All
	fi
fi
qsubout4="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1}"
qsubout4temp="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1}_temp"
qsubout4All="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1}"
qsubout4Alltemp="${mainDir1}/qsubout/qsubout.All.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1}_temp"
if [ -e $qsubout4 ] ; then
	if [ -e $qsubout4All ] ; then
		appendCheckValue=`cat $qsubout4All | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
		
		echo $appendCheckValue | cat $qsubout4All - $qsubout4 > $qsubout4Alltemp
		mv $qsubout4Alltemp $qsubout4All
	else 
		echo "Append_1" | cat - $qsubout4 > $qsubout4All
	fi
fi

#echo $qsubout

#mainDir2, baseFile1, refFileFlag1

#mainCommandsTotal="--vcf ${vcf1} --groupf ${groupf1}.${groupfSpecific} --ped ${ped1}"
mainCommandsTotal="--vcf ${vcf1} --groupf ${groupf1}.${groupfSpecific}.wSplice --ped ${ped1}"

pheno1="--pheno HIVPROG"
pheno2="--pheno HIVPROGHE"
pheno3="--pheno AIDS"
pheno4="--pheno AIDSEXTR"

cov1="--cov RMID --cov PC1 --cov PC2 --cov PC3 --cov PC4 --cov PC5"
#cov1="--cov RMID"

#maxMaf005="--max-maf .05"
maxMaf100="--max-maf 1.0"

#skat0="--test skat --skat-o --skat-adjust --beta 1\,25 "
#skat0flat="--test skat --skat-o --skat-adjust --beta 1\,1 "
skat="--test skat"
#madsen="--test b.madsen"
#collapse="--test b.collapse"
wcnt="--test b.wcnt"
skatAdj="--test skat --skat-adjust"
#skat0="--test skat --skat-o --beta 1\,25 "
#skat0flat="--test skat --skat-o --beta 1\,1 "

run1="--run 6"

echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skat0 $run1 $out1


:<<'END'
END
#Pheno1
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.skat.wAdjust.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat.wAdjust.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skatAdj $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.skat.noAdjust.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.skat.noAdjust.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skat $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.wcnt.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno1.maf1.wcnt.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh

#Pheno2
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.skat.wAdjust.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat.wAdjust.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $skatAdj $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.skat.noAdjust.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.skat.noAdjust.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.wcnt.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno2.maf1.wcnt.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh

#Pheno3
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno3.maf1.skat0.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh

#Pheno4
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1} "; qsubout="${mainDir1}/qsubout/qsubout.EPACTruns.MultiRuns.Launcher.vs3.pt2.ForNullTests.${groupfSpecific}.Pheno4.maf1.skat0.run${runNum1}"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
#qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh

#sleep 1

