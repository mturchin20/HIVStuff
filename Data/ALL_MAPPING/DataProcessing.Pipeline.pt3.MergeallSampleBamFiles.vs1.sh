#!/bin/sh

#######
#
#	Description
#	
#	Note 20130522: mergeFlag1 is never expected to equal 1 now; code is being kept there for the time being to maintain a physical record of the thought process/logic at that time. A separate script is being created that will perform the same functions, collecting /all/ .bam files present in the directory on the per individual level, rather than explicitly just combining the two PTP regions across the single plate/run (e.g. if two separate runs were done or an individual, collect all .bams from all sections of the PTPs for each run and then do the aggregate MarkDup/BQSR steps. Using Pool##_RL## as the sample full/true name)
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Working variables:" $fileDirList1
echo ""

#Variables: $fileDirList1 -- directoryoffile,sffFile;directoryoffile,sffFile;etc..

mkdir /tmp/$PBS_JOBID
cd /tmp/$PBS_JOBID

mainDir2=`echo $fileDirList1 | perl -F/\;/ -ane 'chomp(@F); my @vals1 = split(/\|/, $F[0]); print $vals1[0];' | perl -F/ -ane '$F[7] = "PostMerge"; if ($F[9] =~ m/(POOL\d+).*(\d\dRL)/) { $F[9] = $1 . "_" . $2;  print "/", join("/", @F[1..9]);}'`
baseFileN=`echo $mainDir2 | perl -F/ -ane 'print $F[9];'`

echo $mainDir2 $baseFileN

#/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_106-124/POOL106-01RL,H9Y2FG202.RL1.sff

mergeBamCommand1=`echo $fileDirList1 | perl -F/\;/ -sane 'chomp(@F); foreach my $file1 (@F) { if ($file1) { my @vals1 = split(/\|/, $file1); my $baseFile1; if ($vals1[1] =~ m/(.*)\.sff/) { $baseFile1 = $1; } my $preGATKbam1 = $baseFile1 . ".QCed.preGATK.QCed.bam"; my $totalFile1 = $vals1[0] . "/" . $preGATKbam1; system("cp -p $totalFile1 /tmp/$pbs_jobid1"); print "I=$preGATKbam1\t"; } }' -- -pbs_jobid1=$PBS_JOBID`

#echo $mergeBamCommand1

/home/shared/software/java/jre1.7.0_09/bin/java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MergeSamFiles.jar $mergeBamCommand1 O=${baseFileN}.QCed.preGATK.QCed.samplesMerged.bam SORT_ORDER=coordinate

#ls -lrt > shana.txt

#mv shana.txt $HOME/.

: <<'END'

#cd $mainDir1

#baseFile2=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "02" . $3; } '`
#baseFileN=`echo $baseFile1 | perl -lane 'if ($F[1] =~ m/(.*)(0\d)(\.RL\d+).*/) { print $1 . "0N" . $3; } '`
baseFile= 		#JOBID thing here now?

cp -p $mainDir1/$baseFile1.preGATK.bam /tmp/$PBS_JOBID/.
cp -p $mainDir1/$baseFile2.preGATK.bam /tmp/$PBS_JOBID/.
	
date | xargs echo "Pre GATK/picard/samtools cleanup timepoint:"

#/home/shared/software/samtools/samtools-0.1.19/samtools merge $baseFile1.preGATK.bam $baseFile2.preGATK.bam 
#For loop in perl with variable containing as many 'I=filefilefile' designations as possible and just do ...MergeSamFiles.jar $ThatVariable O=$baseFileN.preGATK.bam
java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MergeSamFiles.jar I=$baseFile1.preGATK.bam I=$baseFile2.preGATK.bam O=$baseFileN.preGATK.bam

java -Xmx4g -jar /home/shared/software/picard/picard-tools-1.91/MarkDuplicates.jar I=$baseFileN.preGATK.bam O=$baseFileN.GATK.rmdup.bam REMOVE_DUPLICATES=TRUE

END

mv /tmp/$PBS_JOBID/$baseFileN* $mainDir2/.

rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
