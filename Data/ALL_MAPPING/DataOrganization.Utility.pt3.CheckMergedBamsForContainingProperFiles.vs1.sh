#!/bin/sh

#File1 Ex: DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

File1="$1"

OLD_IFS="$IFS" 
IFS=$'\n'

#/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_SOLID/POOL13S-02RL|HCJAYPT01.RL2.sff;/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_SOLID/POOL13S-02RL|HCJAYPT02.RL2.sff;

for mergeList1 in `cat $File1`
do

        IFS=$OLD_IFS

	echo $mergeList1 | perl -lane 'my @vals1 = split(/;/, $F[0]); foreach my $entry1 (@vals1) { my @vals2 = split(/\|/, $entry1); my @sffInfo = split(/\./, $vals2[1]); print $sffInfo[0], ".", $sffInfo[1]; } ;' > DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp2
	
	mainDir2=`echo $mergeList1 | perl -F/\;/ -ane 'chomp(@F); my @vals1 = split(/\|/, $F[0]); print $vals1[0];' | perl -F/ -ane '$F[7] = "PostMerge"; if ($F[9] =~ m/(POOL\w+).*(\d\dRL)/) { $F[9] = $1 . "_" . $2;  print "/", join("/", @F[1..9]);}'`
	baseFileN=`echo $mainDir2 | perl -F/ -ane 'print $F[9];'`

	OLD_IFS="$IFS"
	IFS=$'\n'

	for sffFile1 in `cat DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp2`
	do

		IFS=$OLD_IFS

		sffFileCheck1=`samtools view -H $mainDir2/$baseFileN.QCed.preGATK.QCed.samplesMerged.bam | grep ID | grep $sffFile1 | perl -lane 'foreach my $entry (@F) { if ($entry =~ m/^ID/) { my @vals1 = split(/:/, $entry); print $vals1[1]; } }'`

		if [ ! -z $sffFileCheck1 ] ; then
			if [ "$sffFileCheck1" != "$sffFile1" ] ; then
				echo "Error1a -- expected sff file $sffFile1 not found in $mainDir2/$baseFileN.QCed.preGATK.QCed.samplesMerged.bam (\$sffFileCheck1: $sffFileCheck1)" 
			else
#				echo $sffFileCheck1 $sffFile1
				:
			fi
		else
			echo "Error2a -- \$sffFileCheck1 not found (\sffFile1: $sffFile1)"
		fi
	done
done

