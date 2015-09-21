#!/bin/sh

#POOLIDFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

POOLIDFile="$1"

date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

OLD_IFS="$IFS" 
IFS=$'\n'

for bamFile1 in `cat $POOLIDFile`
do
	
	IFS=$OLD_IFS

	POOLID=`echo $bamFile1 | awk '{ print $1 }' | perl -F/ -ane 'if ($F[10] =~ m/(POOL_P2_[0-9]+).*(\d\dRL)/) { print $1; }'`
	indvID=`echo $bamFile1 | awk '{ print $1 }' | perl -F/ -ane 'if ($F[10] =~ m/(POOL_P2_[0-9]+).*(\d\dRL)/) { print $2; }'`

	echo $POOLID

	if [ -z $POOLID ] ; then
		echo "Error1a -- did not retrieve a \$POOLID for the following line: $bamFile1"
	fi

	if [ -z $indvID ] ; then
		echo "Error1b -- did not retrieve a \$indvID for the following line: $bamFile1"
	fi

	cat $POOLIDFile | grep "$POOLID\_\|$POOLID-" | grep $indvID > DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.tempFile

	OLD_IFS="$IFS" 
	IFS=$'\n'

	for bamFile2 in `cat DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.tempFile`
	do
	
		IFS=$OLD_IFS

		echo $bamFile2 | perl -ane 'print $F[0], "|", $F[1], ";";' >> DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output

	done
	
	perl -e 'print "\n";' >> DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output

done

cat DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output | sort | uniq > DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output.tmp1

mv DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output.tmp1 DataOrganization.CreatebamMergeList.vs3.ForP2.vs1.${date1}.output

