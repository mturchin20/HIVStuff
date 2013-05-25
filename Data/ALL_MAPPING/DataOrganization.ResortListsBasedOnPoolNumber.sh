#!/bin/sh

mainFile1="$1"

rm ${mainFile1}.PoolOrderSorted

for i in {1..90}
do
	poolNum=$i
	poolNumLength=`echo $poolNum | perl -ane 'my @vals1 = split(//, $F[0]); if ($#vals1 == 0) { print "0"; } elsif ($#vals1 == 1) { print "1"; } else { print "Error1";}'`
	if [ $poolNumLength -eq "0" ] ; then
		poolNum="0${i}"
	fi

	poolID="POOL${poolNum}"

	echo $poolNumLength $poolNum $poolID

#	cat $mainFile1 | grep "$poolID" | perl -lane 'my @vals1 = split(/\//, $F[0]); if ($vals1[$#vals1] =~ m/(POOL\d\d).*(\d+RL).*/) { my $val1 = $1 . "-" . $2; push(@F, $val1); } print join("\t", @F);' >> 

#	cat $mainFile1 | grep "$poolID" | perl -lane 'my @vals1 = split(/\//, $F[0]); if ($vals1[$#vals1] =~ m/(POOL\d\d).*(\d+RL).*/) { my $val1; if ($2 !~ m/\d\d/) { $val1 = $1 . "-0" . $2; } else { $val1 = $1 . "-" . $2; } push(@F, $val1); } print join("\t", @F);'
	cat $mainFile1 | grep "$poolID" | perl -lane 'my @vals1 = split(/\//, $F[0]); if ($vals1[$#vals1] =~ m/(POOL\d\d).*(\d\dRL).*/) { my $val1 = $1 . "-" . $2; push(@F, $val1); } print join("\t", @F);' >> ${mainFile1}.PoolOrderSorted

	echo "~~~~~~~~~~~~~~~~~" >> ${mainFile1}.PoolOrderSorted.Test1

done
