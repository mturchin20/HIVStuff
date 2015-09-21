#!/bin/sh

beginTime1=`perl -e 'print time;'`

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.WorkingMainList.txt 
#sffLinker1 Ex: DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output

DIRLIST1="$1"
#file1="$2"
sffLinker1="$2"
MergeFolder="$3"
SearchTerm1="$4"

#date1=`date | perl -ane '$F[3] =~ s/:/_/g; print join("_", @F);'`
#date1=`date "+%F_%k%M%S" | sed 's/\-//g'`
date1="20130831_235915"

#for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

	echo $dir	

#	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	for subDir in `cat Pools/$MergeFolder/$dir/${DIRLIST1}.${dir}`
	do
		
		echo $subDir
#		cat $sffLinker1 | grep $subDir > sffListTempFile.txt
#		cd /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir
#		ls -lrt | grep sff > sffListTempFile.txt
#		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep sff | perl -sane 'if ($F[4] <= 1000) { if ($F[8] =~ m/(.*).sff/) { system("cat $sffLinker11 | grep $1 ") } } ' -- -sffLinker11=$sffLinker1 >> DataProcessing.Pipeline.CheckForErroneousFiles.vs1.${date1}.output
#		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep $SearchTerm1 | perl -sane 'if ($F[4] <= 1000) { if ($F[8] =~ m/(.*).(RL\d+).($SearchTerm11)*/) { my $grepTerm1 = $1 . "." . $2; print STDERR $grepTerm1, "\t", join("\t", @F), "\n"; system("cat $sffLinker11 | grep $grepTerm1 ") } } ' -- -sffLinker11=$sffLinker1 -SearchTerm11=$SearchTerm1 >> DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output
#		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep $SearchTerm1 | perl -sane 'if ($F[4] == 0) { if ($F[8] =~ m/(.*).(RL\d+).($SearchTerm11)*/) { my $grepTerm1 = $1 . "." . $2; print STDERR $grepTerm1, "\t", join("\t", @F), "\n"; system("cat $sffLinker11 | grep $grepTerm1 ") } } ' -- -sffLinker11=$sffLinker1 -SearchTerm11=$SearchTerm1 >> DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output

		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep sff | grep RL > /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/sffListTempFile.ErrorChk.txt
#		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep  > /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/sffListTempFile.ErrorChk.txt

#		echo "ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep $SearchTerm1 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/sffListTempFile.ErrorChk.txt"

		OLD_IFS="$IFS" 
		IFS=$'\n'

		for sffFileInfo in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/sffListTempFile.ErrorChk.txt`
		do
			IFS=$OLD_IFS
		
#			echo $sffFileInfo

			baseFile1=`echo $sffFileInfo | awk '{ print $9 } ' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`
#			baseFile1=`echo $sffFileInfo | awk '{ print $9 } ' | perl -sane 'if ($F[0] =~ m/(.*).$SearchTerm11/) { print $1; }' -- -SearchTerm11=$SearchTerm1`
#			sffFile1=${baseFile1}.sff
			sffFile1=${baseFile1}.${SearchTerm1}
			
#			echo $baseFile1
			
			if [ ! -e /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/$sffFile1 ] ; then
				cat $sffLinker1 | grep $subDir | grep $baseFile1 >> DataProcessing.Pipeline.CheckForErroneousFiles.vs2.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output
				echo $sffFile1
			else
				ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/$sffFile1 | perl -sane 'if ($F[4] <= 20) { if ($F[8] =~ m/.*RL\/(.*).(RL\d+).$SearchTerm11.*$/) { my $grepTerm1 = $1 . "." . $2; print STDERR $grepTerm1, "\t", join("\t", @F), "\n"; system("cat $sffLinker11 | grep $subDir1 | grep $grepTerm1 ") } } ' -- -sffLinker11=$sffLinker1 -SearchTerm11=$SearchTerm1 -subDir1=$subDir>> DataProcessing.Pipeline.CheckForErroneousFiles.vs2.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output
#				echo $sffFileInfo | perl -sane 'if ($F[4] <= 1000) { if ($F[8] =~ m/(.*).(RL\d+).$SearchTerm11.*/) { my $grepTerm1 = $1 . "." . $2; print STDERR $grepTerm1, "\t", join("\t", @F), "\n"; system("cat $sffLinker11 | grep $grepTerm1 ") } } ' -- -sffLinker11=$sffLinker1 -SearchTerm11=$SearchTerm1 >> DataProcessing.Pipeline.CheckForErroneousFiles.vs2.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output
#				echo $sffFileInfo | perl -sane 'if ($F[4] <= 1000) { print STDERR join("\t", @F); }' 
#				echo $sffFileInfo
#				ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/$sffFile1 | perl -sane 'if ($F[4] <= 10000) { print STDERR join("\t", @F); }'
			fi


		done


#		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/$MergeFolder/$dir/$subDir/. | grep fastq | perl -lane 'if ($F[4] >= 1000) { print join("\t", @F), "\n"; } '

#		OLD_IFS="$IFS" 
#		IFS=$'\n'

#		for sffListInfo in `cat sffListTempFile.txt`
#		do
#			IFS=$OLD_IFS
	
#			baseFile1=`echo $sffListInfo | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`
#			preGATKbam1=${baseFile1}.preGATK.bam

#			if [ ! -e Pools/$MergeFolder/$dir/$subDir/$preGATKbam1 ] ; then
#				echo $sffListInfo >> DataProcessing.CheckForPresenceOfCertainFile.${date1}.output 
#			fi

#		done
	done
done

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
