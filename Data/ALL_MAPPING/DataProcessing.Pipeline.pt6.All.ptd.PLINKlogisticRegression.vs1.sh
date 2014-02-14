#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged
#baseFile1 Ex: AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

mainDir1="$1"
baseFile1="$2"

#plink --bfile $mainDir1/GATK/${baseFile1}.Samtools.ChrAll.C50.flt --pheno $mainDir1/PLINKfiles/${baseFile1}.pheno --mpheno 1 --covar $mainDir1/PLINKfiles/${baseFile1}.covar --covar-number 1,2 --keep $mainDir1/PLINKfiles/${baseFile1}.covar.WhiteOnly --logistic --allow-no-sex --out $mainDir1/Samtools/${baseFile1}.Samtools.ChrAll.C50.flt.All.Pheno1.Assoc

#plink --bfile $mainDir1/GATK/${baseFile1} --pheno $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar --covar-number 1,2 --keep $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly --logistic --allow-no-sex --out $mainDir1/GATK/${baseFile1}.Pheno1.Assoc

plink --bfile $mainDir1/GATK/${baseFile1} --pheno $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8,9,10,11,12,13 --keep $mainDir1/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly --logistic --allow-no-sex --out $mainDir1/GATK/${baseFile1}.Pheno1.10PCsmaf01geno95.Assoc

#plink --bfile $mainDir1/Samtools/${baseFile1}.Samtools.ChrAll.C50.flt --pheno $mainDir1/PLINKfiles/${baseFile1}.pheno --mpheno 3 --covar $mainDir1/PLINKfiles/${baseFile1}.covar --covar-number 1,2 --keep $mainDir1/PLINKfiles/${baseFile1}.covar.WhiteOnly --extract $mainDir1/Samtools/${baseFile1}.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs --logistic --allow-no-sex --out $mainDir1/Samtools/${baseFile1}.Samtools.ChrAll.C50.flt.SNPsonly.Pheno3.Assoc

