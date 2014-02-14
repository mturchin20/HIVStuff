#!/bin/sh

#DuplicateList1 Ex:
#mergeBamList1 Ex: 

DuplicateList1="$1"
mergeBamList1="$2"

rm ${mergeBamList1}.multPOOLperIndvCollected.newEntries
cp -p ${mergeBamList1} ${mergeBamList1}.multPOOLperIndvCollected.removedEntries

OLD_IFS="$IFS" 
IFS=$'\n'

for combineList1 in `cat $DuplicateList1`
do
	IFS=$OLD_IFS
	
#	echo $combineList1

	OLD_IFS="$IFS"
	IFS=$':'

	read -a indvCombo <<< "$combineList1"

	for indvEntry in "${indvCombo[@]}"
	do
		IFS=$OLD_IFS
	
		OLD_IFS="$IFS"
		IFS=$','

		read -a entryComponents <<< "$indvEntry"


		if [ -e ${mergeBamList1}.multPOOLperIndvCollected.temp1 ] ; then
			cat $mergeBamList1 | grep -i "${entryComponents[1]}-.*${entryComponents[0]}RL" > ${mergeBamList1}.multPOOLperIndvCollected.temp2
			paste ${mergeBamList1}.multPOOLperIndvCollected.temp1 ${mergeBamList1}.multPOOLperIndvCollected.temp2 > ${mergeBamList1}.multPOOLperIndvCollected.temp3
			mv ${mergeBamList1}.multPOOLperIndvCollected.temp3 ${mergeBamList1}.multPOOLperIndvCollected.temp1
			rm ${mergeBamList1}.multPOOLperIndvCollected.temp2
			
			cat ${mergeBamList1}.multPOOLperIndvCollected.removedEntries | grep -i -v "${entryComponents[1]}-.*${entryComponents[0]}RL" > ${mergeBamList1}.multPOOLperIndvCollected.removedEntries.temp1
			mv ${mergeBamList1}.multPOOLperIndvCollected.removedEntries.temp1 ${mergeBamList1}.multPOOLperIndvCollected.removedEntries

		else
			cat $mergeBamList1 | grep -i "${entryComponents[1]}-.*${entryComponents[0]}RL" > ${mergeBamList1}.multPOOLperIndvCollected.temp1
			
			cat ${mergeBamList1}.multPOOLperIndvCollected.removedEntries | grep -i -v "${entryComponents[1]}-.*${entryComponents[0]}RL" > ${mergeBamList1}.multPOOLperIndvCollected.removedEntries.temp1
			mv ${mergeBamList1}.multPOOLperIndvCollected.removedEntries.temp1 ${mergeBamList1}.multPOOLperIndvCollected.removedEntries
		fi

		IFS=$OLD_IFS

	done

	cat ${mergeBamList1}.multPOOLperIndvCollected.temp1 | perl -lane 'print join("", @F);' >> ${mergeBamList1}.multPOOLperIndvCollected.newEntries

	rm ${mergeBamList1}.multPOOLperIndvCollected.temp1

done

cat ${mergeBamList1}.multPOOLperIndvCollected.removedEntries ${mergeBamList1}.multPOOLperIndvCollected.newEntries > ${mergeBamList1}.multPOOLperIndvCollected

