cmd_args = commandArgs()

#Data1 Ex: 

Data1 <- read.table(cmd_args[5], header=FALSE)

Results1 <- c()

for (i in 1:nrow(Data1)) {

#	print(as.character(Data1[i,2]))

	Differences <- as.numeric(strsplit(as.character(Data1[i,2]), ",")[[1]])

	Results1 <- rbind(Results1, c(as.character(Data1[i,1]), length(Differences), mean(Differences), sd(Differences)))

}

#print (Results1)

write.table(Results1,"", quote=FALSE, row.names=FALSE, col.names=FALSE)

