#!/bin/sh

##20141121

cp -p /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.FreeBayes.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh 

cp -p /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.vs1.sh /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.FreeBayes.pta.CreateVCFfilesPerChromosome.vs1.sh

mkdir /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes

bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.FreeBayes.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

#In /home/michaelt/Software 
git clone --recursive git://github.com/ekg/vcflib.git

cd vcflib/

make

cp -p /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs2.sh /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.FreeBayes.ptb.MergeVCFsAcrossChromosomes.vs2.sh

bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.FreeBayes.ptb.MergeVCFsAcrossChromosomes.vs2.sh

zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.vcf.gz | fill-aa -a /home/michaelt/Data/1000G/AncestralAlignments/human_ancestor_GRCh37_e59/human_ancestor_ | gzip -c > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.vcf.gz

zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.vcf.gz | perl /home/shared/software/samtools/samtools-0.1.19/bcftools/vcfutils.pl varFilter -D 1000 | gzip > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.flt.vcf.gz

[  michaelt@node3  ~]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.vcf.gz | wc
 685930 631003832 16356104887
[  michaelt@node3  ~]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.flt.vcf.gz | wc
 312572 287514472 4402853171

python /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.DropOff.VCFVariants.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.flt.vcf.gz --window 1000 | gzip > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.flt.DropOffTarg_1kb.vcf.gz 

python /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.DropOff.VCFVariants.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.vcf.gz --window 1000 | gzip > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.vcf.gz

[  michaelt@node3  ~]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.vcf.gz | wc
 330547 304051472 10489003702
[  michaelt@node3  ~]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.flt.DropOffTarg_1kb.vcf.gz | wc
  12675 11609232 246234194


#GATK wc's for comparison
[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | wc
4696246 4320432886 22982179397
[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.recode.vcf.gz | wc
2649800 2437702566 31009791704
[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.vcf.gz | wc
  93252 85677489 1920152565
[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK]$zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.DropOffTarg_1kb.vcf.gz | wc
 195132 179408006 3803553145


/home/michaelt/Software/vcftools_0.1.12a/bin/vcftools --gzvcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.vcf.gz --missing-indv --out /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb

cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.imiss | awk '{ if ($5 > .99) { print $1 } } ' | grep -v INDV > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.imiss.Above99Miss.justIIDs

#Including Indv99 tag even though not dropping anyone. No one was dropped in the GATK implementation either with the >.99 step. So far only individuals on P2 were dropped based on this step

vcftools --gzvcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.vcf.gz --remove /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.imiss.Above99Miss.justIIDs --geno .95 --recode --recode-INFO-all --out /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95

mv /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.recode.vcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.vcf 

gzip /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.vcf

vcftools --gzvcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.vcf.gz --hwe .0001 --recode --recode-INFO-all --out /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4

mv /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.recode.vcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf

#Note -- takes about ~2-3 days to complete even with -nt 6? With -nt 32 it takes
/home/shared/software/java/jre1.7.0_09/bin/java -Xmx60g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T VariantAnnotator -R /home/michaelt/Data/HumanGenome/GRCh37/Version4/human_g1k_v37.fasta -I /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam  -o /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.HRun.vcf -A HomopolymerRun --variant /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf -nt 32

[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes]$cat AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf | wc
 275817 253699872 9099103080
[  michaelt@node10  /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes]$cat AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.wAA.raw.DropOffTarg_1kb.Indv99.geno95.hwe1e4.HRun.vcf | wc
 275904 253700047 6471720654


##20150105
#Jumping in here to do annovar stuff before having finished the normal HRun results routine so that's why there is the old chunk of code below from the P2 run while new stuff is being inserted here

zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.vcf.gz | awk '{ print $1, "\t", $2, "\t", $2, "\t", $4, "\t", $5 }' | grep -v ^# > /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.vcf.AnnovarFormat 

perl /home/michaelt/Software/annovar/summarize_annovar.pl /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.vcf.AnnovarFormat /home/michaelt/Software/annovar/ --ver1000g 1000g2012apr --verdbsnp 129 --veresp 6500 --buildver hg19 --remove




#Note -- takes about ~2-3 days to complete even with -nt 6? With -nt 32 it takes
/home/shared/software/java/jre1.7.0_09/bin/java -Xmx5g -jar /home/shared/software/GATK/2.5.2/GenomeAnalysisTK.jar -T VariantAnnotator -R /home/michaelt/Data/HumanGenome/GRCh37/Version4/human_g1k_v37.fasta -I /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.bam  -o /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.HRun.vcf -A HomopolymerRun --variant /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.vcf -nt 6

mv /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.HRun.vcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf

mv /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.HRun.vcf.idx /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf.idx

gzip -f /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf

zcat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/AllPools.P2.Vs1.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.Indv99.geno95.hwe1e4.vcf.gz | perl -lane 'my @vals1 = split(/;/, $F[7]); foreach my $SNPinfo (@vals1) { if ($SNPinfo =~ m/HRun/) { print $SNPinfo; } };' | sort | uniq -c

61165 HRun=0                  





##20141219
##Doing some extra coding things to compare results of the mapping/calling pipeline with FreeBayes to results in Samtools and GATK

vcftools --gzvcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.vcf.gz --mac 2 --geno .95 --hwe .0001 --recode  --recode-INFO-all --out /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.mac2.geno95.hwe1e4

mv /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.mac2.geno95.hwe1e4.recode.vcf /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.mac2.geno95.hwe1e4.vcf

gzip /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/FreeBayes/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.FB.w0Flag.ChrAll.SNP.Bi.raw.mac2.geno95.hwe1e4.vcf





