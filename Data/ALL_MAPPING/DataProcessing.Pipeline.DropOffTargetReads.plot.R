cmd_args = commandArgs()
Data1 <- read.table(cmd_args[5], header=FALSE) #Data1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.chr4.bed
Data2 <- read.table(cmd_args[6], header=FALSE) #Data2 Ex: 

jpeg(file=cmd_args[7], height=2000, width=2500, res=300)
plot(NULL, xlim=c(0,190994996), ylim=c(0,5))

#chr4    972761  973392
for (line1 in 1:nrow(Data1)) {
	yVal1 = jitter(4)
	segments(Data1[line1, 2], yVal1, Data1[line1,3], yVal1, col="RED")
#	segments(xcrd$Pos1, ycrd, xcrd$Pos2, ycrd, col=ColorsList)
}

for (line2 in 1:nrow(Data2)) {
	yVal2 = jitter(2, factor=4)
	segments(Data2[line2, 1], yVal2, Data2[line2,2], yVal2, col="BLACK")
}

#plot(log10(Data1[,1]), log10(Data1[,2]), main=paste(Pop1, " - ", ID1, ": Missingness Tracks", sep=""), xlab="Length of Track", ylab="Number of Occurences")
dev.off()
