cmd_args = commandArgs()
library(SKAT)

#Data1 Ex: 

#BedLocation <- cmd_args[5]
#BimLocation <- cmd_args[6]
#FamLocation <- cmd_args[7]
#PhenoLocation <- cmd_args[8]
#SetIDLocation <- cmd_args[9]
#SSDLocation <- paste(cmd_args[10], ".SSD", sep="")
#InfoLocation <- paste(cmd_args[10], ".SSD.info", sep="")

BedLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bed"
BimLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim"
FamLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.fam"
PhenoLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.pheno"
CovarLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.CEUCHBYRI.10PCs.justWhite.QCed.DropIBD.covar"
SetIDLocation_All <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All"
SSDLocation_All <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.SSD"
InfoLocation_All <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.SSD.info"
SetIDLocation_All_mafMax05 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.mafMax05"
SSDLocation_All_mafMax05 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.mafMax05.SSD"
InfoLocation_All_mafMax05 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.mafMax05.SSD.info"
SetIDLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic"
SSDLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic.SSD"
InfoLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic.SSD.info"
infoSetIDLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous"
SSDLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Nonsyn.SSD"
InfoLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Nonsyn.SSD.info"
SetIDLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_PD"
SSDLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.PP2_PD.SSD"
InfoLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.PP2_PD.SSD.info"
SetIDLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_D"
SSDLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.PP2_D.SSD"
InfoLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.PP2_D.SSD.info"

FamData1 <- read.table(FamLocation, header=FALSE)
PhenoData1 <- read.table(PhenoLocation, header=FALSE, stringsAsFactors=FALSE)
CovarData1 <- read.table(CovarLocation, header=FALSE)
SetIDFull1 <- read.csv(SetIDLocation, header=FALSE)

PhenoData2 <- data.frame(matrix(0,nrow=nrow(PhenoData1), ncol=ncol(PhenoData1)))
#PhenoData2 <- c()
for (i in 1:nrow(FamData1)) {
	for (j in 1:nrow(PhenoData1)) {
		if (as.character(PhenoData1[j,1]) == as.character(FamData1[i,1])) {
			PhenoData2[i,] = PhenoData1[j,]
#			PhenoData2 <- rbind(PhenoData2, PhenoData1[j,])
		}
	}
}

#CovarData2 <- data.frame(matrix(0,nrow=nrow(CovarData1), ncol=ncol(CovarData1)))
CovarData2 <- c()
for (i in 1:nrow(FamData1)) {
	for (j in 1:nrow(CovarData1)) {
		if (as.character(CovarData1[j,1]) == as.character(FamData1[i,1])) {
#			CovarData2[i,] = CovarData1[j,]
			CovarData2 <- rbind(CovarData2, CovarData1[j,])
		}
	}
}


Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_All, SSDLocation_All, InfoLocation_All)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_All_mafMax05, SSDLocation_All_mafMax05, InfoLocation_All_mafMax05)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic, SSDLocation_Exonic, InfoLocation_Exonic)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous, SSDLocation_Exonic_Nonsynonymous, InfoLocation_Exonic_Nonsynonymous)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous_PP2_PD, SSDLocation_Exonic_Nonsynonymous_PP2_PD, InfoLocation_Exonic_Nonsynonymous_PP2_PD)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous_PP2_D, SSDLocation_Exonic_Nonsynonymous_PP2_D, InfoLocation_Exonic_Nonsynonymous_PP2_D)

SSD.INFO.All <- Open_SSD(SSDLocation_All, InfoLocation_All)
obj.All <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D")
out.All <-SKAT.SSD.All(SSD.INFO.All, obj.All, method="optimal.adj")

out.All$results

out.All.AMD5 <- SKAT( Get_Genotypes_SSD(SSD.INFO.All, 9), obj.All)

Close_SSD()

SSD.INFO.Exonic <- Open_SSD(SSDLocation_Exonic, InfoLocation_Exonic)
obj.Exonic <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D")
out.Exonic <-SKAT.SSD.All(SSD.INFO.Exonic, obj.Exonic, method="optimal.adj")

out.Exonic$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous <- Open_SSD(SSDLocation_Exonic_Nonsynonymous, InfoLocation_Exonic_Nonsynonymous)
obj.Exonic_Nonsynonymous <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous, obj.Exonic_Nonsynonymous, method="optimal.adj")

out.Exonic_Nonsynonymous$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous_PP2_PD <- Open_SSD(SSDLocation_Exonic_Nonsynonymous_PP2_PD, InfoLocation_Exonic_Nonsynonymous_PP2_PD)
obj.Exonic_Nonsynonymous_PP2_PD <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous_PP2_PD <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous_PP2_PD, obj.Exonic_Nonsynonymous_PP2_PD, method="optimal.adj")

out.Exonic_Nonsynonymous_PP2_PD$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous_PP2_D <- Open_SSD(SSDLocation_Exonic_Nonsynonymous_PP2_D, InfoLocation_Exonic_Nonsynonymous_PP2_D)
obj.Exonic_Nonsynonymous_PP2_D <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous_PP2_D <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous_PP2_D, obj.Exonic_Nonsynonymous_PP2_D, method="optimal.adj")

#out.Exonic_Nonsynonymous_PP2_D$results
sort(out.Exonic_Nonsynonymous_PP2_D$results[,2])[0:10]

Close_SSD()

out.Exonic_Nonsynonymous_PP2_D$results[order(out.Exonic_Nonsynonymous_PP2_D$results[,2]),]

SSD.INFO.All <- Open_SSD(SSDLocation_All, InfoLocation_All)
obj.All <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D", Adjustment=FALSE)
out.All <- SKAT.SSD.All(SSD.INFO.All, obj.All, method="optimal.adj")
out.All.noAdj <-SKAT.SSD.All(SSD.INFO.All, obj.All, method="optimal")
out.All.noAdj.beta1_1 <-SKAT.SSD.All(SSD.INFO.All, obj.All, weights.beta=c(1,1), method="optimal")
out.All.davies <-SKAT.SSD.All(SSD.INFO.All, obj.All, method="davies")

out.All$results[order(out.All$results[,2]),]
out.All$results[order(out.All$results[,2], decreasing=TRUE),][(nrow(out.All$results)-10):nrow(out.All$results),]
out.All.noAdj$results[order(out.All.noAdj$results[,2], decreasing=TRUE),][(nrow(out.All.noAdj$results)-10):nrow(out.All.noAdj$results),]
out.All.noAdj.beta1_1$results[order(out.All.noAdj.beta1_1$results[,2], decreasing=TRUE),][(nrow(out.All.noAdj.beta1_1$results)-10):nrow(out.All.noAdj.beta1_1$results),]



obj.All.cov <- SKAT_Null_Model(PhenoData2[,3]-1 ~ CovarData2[,4] + CovarData2[,6] + CovarData2[,7] + CovarData2[,8] + CovarData2[,9] + CovarData2[,10], out_type="D", Adjustment=FALSE)
CovarUse <- cbind(CovarData2[,4], CovarData2[,6], CovarData2[,7], CovarData2[,8], CovarData2[,9], CovarData2[,10])
obj.All.cov2 <- SKAT_Null_Model(PhenoData2[,3]-1 ~ CovarUse-1, out_type="D", Adjustment=FALSE)
obj.All.cov3 <- SKAT_Null_Model(PhenoData2[,3]-1 ~ CovarUse, out_type="D", Adjustment=FALSE)
out.All.cov <- SKAT.SSD.All(SSD.INFO.All, obj.All.cov, weights.beta=c(1,25), method="optimal")
out.All.cov2 <- SKAT.SSD.All(SSD.INFO.All, obj.All.cov2, weights.beta=c(1,25), method="optimal")
out.All.cov3 <- SKAT.SSD.All(SSD.INFO.All, obj.All.cov3, weights.beta=c(1,25), method="optimal")

out.All.cov$results[order(out.All.cov$results[,2], decreasing=TRUE),][(nrow(out.All.cov$results)-10):nrow(out.All.cov$results),]
out.All.cov2$results[order(out.All.cov2$results[,2], decreasing=TRUE),][(nrow(out.All.cov2$results)-10):nrow(out.All.cov2$results),]
out.All.cov3$results[order(out.All.cov3$results[,2], decreasing=TRUE),][(nrow(out.All.cov3$results)-10):nrow(out.All.cov3$results),]

Close_SSD()

SSD.INFO.All_mafMax05 <- Open_SSD(SSDLocation_All_mafMax05, InfoLocation_All_mafMax05)
obj.All_mafMax05 <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D", n.Resampling=0, type.Resampling="bootstrap", Adjustment=FALSE)
out.All_mafMax05 <-SKAT.SSD.All(SSD.INFO.All_mafMax05, obj.All_mafMax05, method="optimal.adj")
out.All_mafMax05.noAdj <-SKAT.SSD.All(SSD.INFO.All_mafMax05, obj.All_mafMax05, method="optimal",kernel="linear.weighted",impute.method="fixed")

out.All_mafMax05$results
out.All_mafMax05$results[order(out.All_mafMax05$results[,2], decreasing=TRUE),][(nrow(out.All_mafMax05$results)-10):nrow(out.All_mafMax05$results),]
out.All_mafMax05.noAdj$results[order(out.All_mafMax05.noAdj$results[,2], decreasing=TRUE),][(nrow(out.All_mafMax05.noAdj$results)-10):nrow(out.All_mafMax05.noAdj$results),]

Close_SSD()

Results1 <- c()

write.table(Results1,"", quote=FALSE, row.names=FALSE, col.names=FALSE)

if (FALSE) {
BedLocation.ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bed"
BimLocation.ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim"
FamLocation.ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.fam"

SetIDLocation_All_ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.ADM5"
SSDLocation_All_ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.ADM5.SSD"
InfoLocation_All_ADM5 <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.SetIDFile.All.ADM5.SSD.info"


Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_All_ADM5, SSDLocation_All_ADM5, InfoLocation_All_ADM5)

Crho <- c(0,.1^2,.2^2,.3^2,.4^2,.5^2,.5,1)
Rrho <- c(0,.1^2,.2^2,.3^2,.4^2,.5^2,.5,1)

SSD.INFO.All_ADM5 <- Open_SSD(SSDLocation_All_ADM5, InfoLocation_All_ADM5)
obj.All_ADM5 <- SKAT_Null_Model(PhenoData2[,3]-1 ~ 1, out_type="D", Adjustment=FALSE)
out.All_ADM5 <-SKAT.SSD.All(SSD.INFO.All_ADM5, obj.All_ADM5, method="optimal")
out.All_CR_ADM5 <- SKAT_CommonRare(Get_Genotypes_SSD(SSD.INFO.All_ADM5, 1), obj.All_ADM5, r.corr.common=Crho, r.corr.rare=Rrho)



out.All_ADM5$results

Close_SSD()
}
