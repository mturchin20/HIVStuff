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

BedLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bed"
BimLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim"
FamLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.fam"
PhenoLocation <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.pheno"
SetIDLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic"
SSDLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic.SSD"
InfoLocation_Exonic <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic.SSD.info"
SetIDLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous"
SSDLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Nonsyn.SSD"
InfoLocation_Exonic_Nonsynonymous <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Nonsyn.SSD.info"
SetIDLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_PD"
SSDLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.PP2_PD.SSD"
InfoLocation_Exonic_Nonsynonymous_PP2_PD <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.PP2_PD.SSD.info"
SetIDLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_D"
SSDLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.PP2_D.SSD"
InfoLocation_Exonic_Nonsynonymous_PP2_D <- "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.QCed.bim.wGeneIDs.SetIDFile.PP2_D.SSD.info"

PhenoData1 <- read.table(PhenoLocation, header=FALSE)
SetIDFull1 <- read.csv(SetIDLocation, header=FALSE)

Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic, SSDLocation_Exonic, InfoLocation_Exonic)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous, SSDLocation_Exonic_Nonsynonymous, InfoLocation_Exonic_Nonsynonymous)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous_PP2_PD, SSDLocation_Exonic_Nonsynonymous_PP2_PD, InfoLocation_Exonic_Nonsynonymous_PP2_PD)
Generate_SSD_SetID(BedLocation, BimLocation, FamLocation, SetIDLocation_Exonic_Nonsynonymous_PP2_D, SSDLocation_Exonic_Nonsynonymous_PP2_D, InfoLocation_Exonic_Nonsynonymous_PP2_D)

SSD.INFO.Exonic <- Open_SSD(SSDLocation_Exonic, InfoLocation_Exonic)
obj.Exonic <- SKAT_Null_Model(PhenoData1[,3]-1 ~ 1, out_type="D")
out.Exonic <-SKAT.SSD.All(SSD.INFO.Exonic, obj.Exonic, method="optimal.adj")

out.Exonic$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous <- Open_SSD(SSDLocation_Exonic_Nonsynonymous, InfoLocation_Exonic_Nonsynonymous)
obj.Exonic_Nonsynonymous <- SKAT_Null_Model(PhenoData1[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous, obj.Exonic_Nonsynonymous, method="optimal.adj")

out.Exonic_Nonsynonymous$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous_PP2_PD <- Open_SSD(SSDLocation_Exonic_Nonsynonymous_PP2_PD, InfoLocation_Exonic_Nonsynonymous_PP2_PD)
obj.Exonic_Nonsynonymous_PP2_PD <- SKAT_Null_Model(PhenoData1[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous_PP2_PD <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous_PP2_PD, obj.Exonic_Nonsynonymous_PP2_PD, method="optimal.adj")

out.Exonic_Nonsynonymous_PP2_PD$results

Close_SSD()

SSD.INFO.Exonic_Nonsynonymous_PP2_D <- Open_SSD(SSDLocation_Exonic_Nonsynonymous_PP2_D, InfoLocation_Exonic_Nonsynonymous_PP2_D)
obj.Exonic_Nonsynonymous_PP2_D <- SKAT_Null_Model(PhenoData1[,3]-1 ~ 1, out_type="D")
out.Exonic_Nonsynonymous_PP2_D <-SKAT.SSD.All(SSD.INFO.Exonic_Nonsynonymous_PP2_D, obj.Exonic_Nonsynonymous_PP2_D, method="optimal.adj")

#out.Exonic_Nonsynonymous_PP2_D$results
sort(out.Exonic_Nonsynonymous_PP2_D$results[,2])[0:10]

Close_SSD()


out.Exonic_Nonsynonymous_PP2_D$results[order(out.Exonic_Nonsynonymous_PP2_D$results[,2]),]



Results1 <- c()

write.table(Results1,"", quote=FALSE, row.names=FALSE, col.names=FALSE)

