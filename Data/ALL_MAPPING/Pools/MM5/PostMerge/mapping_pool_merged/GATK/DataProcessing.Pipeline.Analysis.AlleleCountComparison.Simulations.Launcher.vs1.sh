#!/bin/sh

START1=$1
END1=$2

if [ ! -e /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/DataProcessing.Pipeline.Analysis.AlleleCountComparison.Simulations.Launcher.vs1.seedList ] ; then 
	perl /home/michaelt/Scripts/Perl/RandomList.pl --total 1000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/DataProcessing.Pipeline.Analysis.AlleleCountComparison.Simulations.Launcher.vs1.seedList
fi

for i in $(eval echo {$START1..$END1})
#for i in {1..100}
do
	SEED1=`cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/DataProcessing.Pipeline.Analysis.AlleleCountComparison.Simulations.Launcher.vs1.seedList | awk '{ if (NR == '$i') { print $0 } }'`
	qsubout1="/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/qsubout/DataProcessing.Pipeline.Analysis.AlleleCountComparison.Simulations.Launcher.qsubout.round${i}"

	echo $SEED1 $qsubout1

	qsub -j oe -o $qsubout1 -e $qsubout1 -l walltime=72:00:00,mem=6gb,nodes=1:ppn=6 -v ROUND1=$i,SEED1=$SEED1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.AlleleCountComparison.Simulations.vs1.sh

done









