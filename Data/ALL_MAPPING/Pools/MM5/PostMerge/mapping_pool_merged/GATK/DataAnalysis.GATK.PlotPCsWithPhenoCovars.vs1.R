cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped 
#cmd_args[6] Ex:

Data1 <- read.table(cmd_args[5], header=FALSE)

jpeg(file=cmd_args[6], height=8000, width=4000, res=300)
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

