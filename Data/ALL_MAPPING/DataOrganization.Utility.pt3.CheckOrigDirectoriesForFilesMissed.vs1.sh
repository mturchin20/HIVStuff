#!/bin/sh

#File1 Ex: DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

File1="$1"

OLD_IFS="$IFS" 
IFS=$'\n'

#/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_SOLID/POOL13S-02RL|HCJAYPT01.RL2.sff;/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_SOLID/POOL13S-02RL|HCJAYPT02.RL2.sff;

for mergeList1 in `cat $File1`
do

        IFS=$OLD_IFS

	echo $mergeList1 | perl -lane 'my @vals1 = split(/;/, $F[0]); foreach my $entry1 (@vals1) { my @vals2 = split(/\|/, $entry1); print $vals2[0]; } ;' > DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp1
	echo $mergeList1 | perl -lane 'my @vals1 = split(/;/, $F[0]); foreach my $entry1 (@vals1) { my @vals2 = split(/\|/, $entry1); print $vals2[1]; } ;' > DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp2
	
	OLD_IFS="$IFS"
	IFS=$'\n'

	for directory1 in `cat DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp1`
	do

		IFS=$OLD_IFS
	
		ls -lrt $directory1/. | grep sff | grep RL | awk '{ print $9 }' > DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp3
	
		OLD_IFS="$IFS"
		IFS=$'\n'

		for sffFile1 in `cat DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp3`
		do
			IFS=$OLD_IFS
		
#			echo $sffFile1

			check1=`cat DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.temp2 | grep $sffFile1`

			if [ -z $check1 ] ; then
				echo "Error1a -- file $sffFile1 missing from directory $directory1"
			fi

		done

	done


done

