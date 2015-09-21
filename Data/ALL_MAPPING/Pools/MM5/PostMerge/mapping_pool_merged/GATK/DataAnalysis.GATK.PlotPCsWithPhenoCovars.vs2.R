cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped 
#Data2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EigenstratFiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.UBR4.AlleleCounts 
#Data3 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EigenstratFiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.UBR4.TopSNPs.perIndvSumAC  
#cmd_args[8] Ex:
#cmd_args[9] Ex: 

Data1 <- read.table(cmd_args[5], header=FALSE)
Data2 <- read.table(cmd_args[6], header=FALSE)
Data3 <- t(read.table(cmd_args[7], header=FALSE))

if (FALSE) {
jpeg(file=cmd_args[8], height=8000, width=4000, res=300)
par(mfrow=c(6,2))

plot(Data1[,11], Data1[,12], main="PC1 vs. PC2; All", col=Data1[,6])
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; All", col=Data1[,6])
plot(Data1[,15], Data1[,16], main="PC5 vs. PC6; All", col=Data1[,6])

Data1HE <- Data1[!is.na(Data1[,7]),]

plot(Data1HE[,11], Data1HE[,12], main="PC1 vs. PC2; HESeroNeg", col=Data1HE[,6])
plot(Data1HE[,13], Data1HE[,14], main="PC3 vs. PC4; HESeroNeg", col=Data1HE[,6])
plot(Data1HE[,15], Data1HE[,16], main="PC5 vs. PC6; HESeroNeg", col=Data1HE[,6])

Data1Prog <- Data1[!is.na(Data1[,8]),]

plot(Data1Prog[,11], Data1Prog[,12], main="PC1 vs. PC2; Prog", col=Data1Prog[,8])
plot(Data1Prog[,13], Data1Prog[,14], main="PC3 vs. PC4; Prog", col=Data1Prog[,8])
plot(Data1Prog[,15], Data1Prog[,16], main="PC5 vs. PC6; Prog", col=Data1Prog[,8])

plot(Data1[,11], Data1[,12], main="PC1 vs. PC2; All", col=Data1[,10])
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; All", col=Data1[,10])
plot(Data1[,15], Data1[,16], main="PC5 vs. PC6; All", col=Data1[,10])

dev.off()
}

colorCounts <- c()
nameTrack <- c()

for (i in 1:nrow(Data1)) {
	colorCounts <- c(colorCounts, Data2[Data2[,1]==Data1[i,1],2])
	nameTrack <- c(nameTrack, Data2[Data2[,1]==Data1[i,1],1])
}

Data1b <- cbind(Data1, colorCounts, nameTrack)

head(Data1b)

colfunc <- colorRampPalette(c("blue", "red"))

jpeg(file=cmd_args[9], height=8000, width=4000, res=300)
par(mfrow=c(6,2))

#Done with all UBR4 SNPs
#plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; All", col=colfunc(length(seq(range(Data2[,2])[1], range(Data2[,2])[2], by=25)))[findInterval(Data2[,2], seq(range(Data2[,2])[1], range(Data2[,2])[2], by=25))])

#Done with 'top' PC3 UBR4 SNPs
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; All", col=colfunc(length(seq(range(Data2[,2])[1], range(Data2[,2])[2], by=25)))[findInterval(Data2[,2], seq(range(Data2[,2])[1], range(Data2[,2])[2], by=25))])

plot(Data1b[,ncol(Data1b)-1], Data1b[,13], main="UBR4 Top SNP Major ACs vs. PC3")
abline(lm(Data1b[,13] ~ Data1b[,ncol(Data1b)-1]), col="red")
summary(lm(Data1b[,13] ~ Data1b[,ncol(Data1b)-1]))

colorsUse <- c()

for (i in 1:nrow(Data1)) {
	colorsUse <- c(colorsUse, as.numeric(as.character(Data3[Data3[,1]==Data1[i,1], 2]))+1)
}

colorsUse

plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; 1st SNP", col=colorsUse)

colorsUse <- c()
for (i in 1:nrow(Data1)) {
	colorsUse <- c(colorsUse, as.numeric(as.character(Data3[Data3[,1]==Data1[i,1], 3]))+1)
}
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; 2nd SNP", col=colorsUse)
colorsUse <- c()
for (i in 1:nrow(Data1)) {
	colorsUse <- c(colorsUse, as.numeric(as.character(Data3[Data3[,1]==Data1[i,1], 4]))+1)
}
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; 3rd SNP", col=colorsUse)
colorsUse <- c()
for (i in 1:nrow(Data1)) {
	colorsUse <- c(colorsUse, as.numeric(as.character(Data3[Data3[,1]==Data1[i,1], 5]))+1)
}
plot(Data1[,13], Data1[,14], main="PC3 vs. PC4; 4th SNP", col=colorsUse)


dev.off()

