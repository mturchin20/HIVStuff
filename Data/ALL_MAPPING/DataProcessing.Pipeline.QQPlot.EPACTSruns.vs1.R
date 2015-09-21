cmd_args = commandArgs()

#cmd_args[5] Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs
#cmd_args[6] Ex: Pheno1
#cmd_args[7] Ex: HIV_Acquisition_justWhite_RMID5PCs
#cmd_args[8] Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.Everything.Pheno1.maf1.skat0.QQplot.jpeg

Data1 <- read.table(paste(cmd_args[5], ".All.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data2 <- read.table(paste(cmd_args[5], ".Exonic.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data3 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data4 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.PP2_PD.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data5 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.PP2_D.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data6 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.Sift_D.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data7 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.LRT_D.", cmd_args[6], ".maf1.skat0.epacts", sep=""), header=TRUE)
Data8 <- read.table(paste(cmd_args[5], ".Exonic.Nonsynonymous.LRT_D.", cmd_args[6], ".maf1.skat0.perm1.epacts", sep=""), header=TRUE)

#AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.Exonic.Nonsynonymous.LRT_D.Pheno2.maf1.skat0.ind

Data1subset <- Data1[!is.na(Data1[,10]),][order( Data1[!is.na(Data1[,10]),][,10], decreasing=FALSE),]
Data2subset <- Data2[!is.na(Data2[,10]),][order( Data2[!is.na(Data2[,10]),][,10], decreasing=FALSE),]
Data3subset <- Data3[!is.na(Data3[,10]),][order( Data3[!is.na(Data3[,10]),][,10], decreasing=FALSE),]
Data4subset <- Data4[!is.na(Data4[,10]),][order( Data4[!is.na(Data4[,10]),][,10], decreasing=FALSE),]
Data5subset <- Data5[!is.na(Data5[,10]),][order( Data5[!is.na(Data5[,10]),][,10], decreasing=FALSE),]
Data6subset <- Data6[!is.na(Data6[,10]),][order( Data6[!is.na(Data6[,10]),][,10], decreasing=FALSE),]
Data7subset <- Data7[!is.na(Data7[,10]),][order( Data7[!is.na(Data7[,10]),][,10], decreasing=FALSE),]
Data8subset <- Data8[!is.na(Data8[,10]),][order( Data8[!is.na(Data8[,10]),][,10], decreasing=FALSE),]


#xVals1 <- seq(1/nrow(Data1subset),1,by=1/nrow(Data1subset))
xVals1 <- c(1:nrow(Data1subset))/(nrow(Data1subset)+1)

jpeg(file=cmd_args[8], height=2125, width=2125, res=300)
#pdf(file=cmd_args[8], height=7, width=7)

plot(-1*log10(xVals1), -1*log10(Data1subset[,10]), ylim=c(0,3.75), xlab="-log10 Expected p-Values", ylab="-log10 Observed p-Values", main=cmd_args[7], type="b", col="RED")
abline(a=0, b=1)
lines(-1*log10(c(1:nrow(Data2subset))/(nrow(Data2subset)+1)), -1*log10(Data2subset[,10]), type="b", col="BLUE")
lines(-1*log10(c(1:nrow(Data3subset))/(nrow(Data3subset)+1)), -1*log10(Data3subset[,10]), type="b", col="GREEN")
lines(-1*log10(c(1:nrow(Data4subset))/(nrow(Data4subset)+1)), -1*log10(Data4subset[,10]), type="b", col="PURPLE")
lines(-1*log10(c(1:nrow(Data5subset))/(nrow(Data5subset)+1)), -1*log10(Data5subset[,10]), type="b", col="YELLOW")
lines(-1*log10(c(1:nrow(Data6subset))/(nrow(Data6subset)+1)), -1*log10(Data6subset[,10]), type="b", col="ORANGE")
lines(-1*log10(c(1:nrow(Data7subset))/(nrow(Data7subset)+1)), -1*log10(Data7subset[,10]), type="b", col="BROWN")
lines(-1*log10(c(1:nrow(Data8subset))/(nrow(Data8subset)+1)), -1*log10(Data8subset[,10]), type="b", col="BLACK")

legend(2, 1.5, c("All", "Exonic", "Nonsynonymous", "PP2_PD", "PP2_D", "Sift_D", "LRT_D", "All_Perm"), pch=c(1,1,1,1,1,1,1,1), col=c("RED", "BLUE", "GREEN", "PURPLE", "YELLOW", "ORANGE", "BROWN", "BLACK"))
#legend(2, 1.5, c("All", "Exonic", "Nonsynonymous", "PP2_PD", "PP2_D", "Sift_D", "LRT_D"), pch=c(1,1,1,1,1,1,1), col=c("RED", "BLUE", "GREEN", "PURPLE", "YELLOW", "ORANGE", "BROWN"))

dev.off()
