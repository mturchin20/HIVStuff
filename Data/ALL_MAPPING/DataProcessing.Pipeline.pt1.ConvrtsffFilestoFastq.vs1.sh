#!/bin/sh

#######
#
#	Description
#	20130519: Convert sff files to fastq files using sff_extract then QC fastq reads via prinseq
#
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
PBSnodeFile=`cat $PBS_NODEFILE`
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~ ${PBS_JOBID} ~ ${date1} ~ ${PBS_O_HOST} ~ ${PBS_O_WORKDIR} ~ ${PBSnodeFile} ~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

#Variables: $totalDir, $baseFile1

mkdir /tmp/$PBS_JOBID
cd /tmp/$PBS_JOBID

#cd $totalDir

#fastqFile1=`echo $sffFile1 | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1 . ".fastq"; }'`

#python /home/michaelt/Software/seq_crumbs-0.1.7/crumbs/sff_extract.py -c $baseFile1.sff | gzip > $baseFile1.fastq.gz
#sff_extract -c $totalDir/$baseFile1.sff | gzip > $baseFile1.fastq.gz

#: <<'END'

totalReadsPreQC=`zcat $totalDir/$baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_info | grep reads | awk '{ print $3 }'`
meanLength=`zcat $totalDir/$baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_len | grep mean | awk '{ print $3 }'`
stdLength=`zcat $totalDir/$baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_len | grep stddev | awk '{ print $3 }'`
#uppBnd=$(($meanLength + ($stdLength * 2)))
#uppBnd=`printf "%.0f" $(echo "$meanLength + ($stdLength * 2)" | bc)`

#echo "General_QC_stats: $totalReadsPreQC $meanLength $stdLength $uppBnd"
#echo "General_QC_stats: $totalReadsPreQC $meanLength $stdLength $uppBnd" > $baseFile1.fastq.stats
echo "General_QC_stats: $totalReadsPreQC $meanLength $stdLength" > $baseFile1.fastq.stats

#echo "PreQC"
echo "PreQC" >> $baseFile1.fastq.stats
#zcat $baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_all
#zcat $baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_all >> $baseFile1.fastq.stats
zcat $totalDir/$baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_all >> $baseFile1.fastq.stats
#zcat $baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_len


#zcat $baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -out_good $baseFile1.QCed -out_bad null -min_len 60 -max_len $uppBnd -min_qual_mean 25 -ns_max_p 1 
#zcat $baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -out_good $baseFile1.QCed -out_bad null -min_len 30
zcat $totalDir/$baseFile1.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -out_good $baseFile1.QCed -out_bad null -min_len 30
gzip -f $baseFile1.QCed.fastq

totalReadsPostQC=`zcat $baseFile1.QCed.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_info | grep reads | awk '{ print $3 }'`
totalReadsDropped=$(($totalReadsPreQC - $totalReadsPostQC))

#echo "PostQC"
echo "PostQC" >> $baseFile1.fastq.stats
#zcat $baseFile1.QCed.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_all
zcat $baseFile1.QCed.fastq.gz | perl /home/michaelt/Software/prinseq-lite-0.20.3/prinseq-lite.pl -fastq stdin -stats_all >> $baseFile1.fastq.stats

#date >> $baseFile1.fastq.stats
#echo "Total_reads_dropped: $totalReadsDropped ($totalReadsPreQC - $totalReadsPostQC)"
echo "Total_reads_dropped: $totalReadsDropped ($totalReadsPreQC - $totalReadsPostQC)" >> $baseFile1.fastq.stats

#END

mv /tmp/$PBS_JOBID/* $totalDir/.

rm -r /tmp/$PBS_JOBID

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
