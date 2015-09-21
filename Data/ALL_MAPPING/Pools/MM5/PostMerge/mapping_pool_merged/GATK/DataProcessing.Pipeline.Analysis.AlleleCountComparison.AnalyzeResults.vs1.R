cmd_args = commandArgs()

#Data1Loc Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.WhiteOnly.QCed.justSeroNeg.permuteVsAll.frq.count.VariantInfo.AnnovarAnnotation.txt.gz
#Data2Loc Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SimulationFiles/AlleleCounts/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.WhiteOnly.QCed.justSeroPos.permuteVsAll.frq.count.VariantInfo.AnnovarAnnotation.txt.gz

FnlRslts <- c("Gene", "Phenotype", "Exonic_Control", "Exonic_Case", "Exonic_binom_pVal", "Exonic_Perm_pVal", "ExonicNonSyn_Control", "ExonicNonSyn_Case", "ExonicNonSyn_binom_pVal", "ExonicNonSyn_Perm_pVal", "ExonicNonSynPP2PD_Control", "ExonicNonSynPP2PD_Case", "ExonicNonSynPP2PD_binom_pVal", "ExonicNonSynPP2PD_Perm_pVal", "ExonicNonSynPP2D_Control", "ExonicNonSynPP2D_Case", "ExonicNonSynPP2D_binom_pVal", "ExonicNonSynPP2D_Perm_pVal")

AlleleCounts <- function(Data1Loc, Data2Loc, Pheno1, FuncCall) {

	Data1 <- read.csv(Data1Loc, header=FALSE)
	Data2 <- read.csv(Data2Loc, header=FALSE)
	FnlRslts_temp <- c() 
		
	write.table(Data1[1:5,], stderr())

	GeneIDs <- unique(Data1$V11)

	for (Gene in GeneIDs[1:20]) {


		Data1Gene <- Data1[Data1$V11==Gene,]
		Data2Gene <- Data2[Data2$V11==Gene,]

		Data1Gene_Exonic <- Data1Gene[Data1Gene[,10]=="exonic",]
		Data2Gene_Exonic <- Data2Gene[Data2Gene[,10]=="exonic",]
		Data1Gene_ExonicNonSyn <- Data1Gene_Exonic[Data1Gene_Exonic[,12]=="nonsynonymous SNV" | Data1Gene_Exonic[,12]=="stopgain" | Data1Gene_Exonic[,12]=="stoploss", ]
		Data2Gene_ExonicNonSyn <- Data2Gene_Exonic[Data2Gene_Exonic[,12]=="nonsynonymous SNV" | Data2Gene_Exonic[,12]=="stopgain" | Data2Gene_Exonic[,12]=="stoploss", ]
		Data1Gene_ExonicNonSyn_PP2PD <- Data1Gene_ExonicNonSyn[Data1Gene_ExonicNonSyn[,22]=="P" | Data1Gene_ExonicNonSyn[,22]=="D",]	
		Data2Gene_ExonicNonSyn_PP2PD <- Data2Gene_ExonicNonSyn[Data2Gene_ExonicNonSyn[,22]=="P" | Data2Gene_ExonicNonSyn[,22]=="D",]	
		Data1Gene_ExonicNonSyn_PP2D <- Data1Gene_ExonicNonSyn[Data1Gene_ExonicNonSyn[,22]=="D",]	
		Data2Gene_ExonicNonSyn_PP2D <- Data2Gene_ExonicNonSyn[Data2Gene_ExonicNonSyn[,22]=="D",]	

		Data1Gene_Exonic_RealScore <- NULL
		Data1Gene_Exonic_binomTest <- NULL
		Data1Gene_ExonicNonSyn_RealScore <- NULL
		Data1Gene_ExonicNonSyn_binomTest <- NULL
		Data1Gene_ExonicNonSyn_PP2PD_RealScore <- NULL
		Data1Gene_ExonicNonSyn_PP2PD_binomTest <- NULL
		Data1Gene_ExonicNonSyn_PP2D_RealScore <- NULL
		Data1Gene_ExonicNonSyn_PP2D_binomTest <- NULL

		write(c(sum(Data1Gene_Exonic[,32]), sum(Data2Gene_Exonic[,32]), sum(c(Data1Gene_Exonic[,32], Data2Gene_Exonic[,32]))), stderr())

		if (nrow(Data1Gene_Exonic) > 0) { 
			if (sum(c(Data1Gene_Exonic[,32], Data2Gene_Exonic[,32])) == 0) {
				Data1Gene_Exonic_RealScore <- "NA"
				Data1Gene_Exonic_binomTest <- "NA"
			}
			else {
				Data1Gene_Exonic_RealScore <- sum(Data1Gene_Exonic[,32]) / sum(c(Data1Gene_Exonic[,32], Data2Gene_Exonic[,32]))
				Data1Gene_Exonic_binomTest <- binom.test(sum(Data1Gene_Exonic[,32]), sum(c(Data1Gene_Exonic[,32], Data2Gene_Exonic[,32])))$p.value
			}
		}
		else {
			Data1Gene_Exonic_RealScore <- "NA"
			Data1Gene_Exonic_binomTest <- "NA"
		}

		if (nrow(Data1Gene_ExonicNonSyn) > 0) {
			if (sum(c(Data1Gene_ExonicNonSyn[,32], Data2Gene_ExonicNonSyn[,32])) == 0) {
				Data1Gene_ExonicNonSyn_RealScore <- "NA"
				Data1Gene_ExonicNonSyn_binomTest <- "NA"
			}
			else {
				Data1Gene_ExonicNonSyn_RealScore <- sum(Data1Gene_ExonicNonSyn[,32]) / sum(c(Data1Gene_ExonicNonSyn[,32], Data2Gene_ExonicNonSyn[,32]))
				Data1Gene_ExonicNonSyn_binomTest <- binom.test(sum(Data1Gene_ExonicNonSyn[,32]), sum(c(Data1Gene_ExonicNonSyn[,32], Data2Gene_ExonicNonSyn[,32])))$p.value
			}
		}
		else {
			Data1Gene_ExonicNonSyn_RealScore <- "NA"
			Data1Gene_ExonicNonSyn_binomTest <- "NA"
		}

		if (nrow(Data1Gene_ExonicNonSyn_PP2PD) > 0) {
			if (sum(c(Data1Gene_ExonicNonSyn_PP2PD[,32], Data2Gene_ExonicNonSyn_PP2PD[,32])) == 0) {
				Data1Gene_ExonicNonSyn_PP2PD_RealScore <- "NA"
				Data1Gene_ExonicNonSyn_PP2PD_binomTest <- "NA"
			}
			else {
				Data1Gene_ExonicNonSyn_PP2PD_RealScore <- sum(Data1Gene_ExonicNonSyn_PP2PD[,32]) / sum(c(Data1Gene_ExonicNonSyn_PP2PD[,32], Data2Gene_ExonicNonSyn_PP2PD[,32]))
				Data1Gene_ExonicNonSyn_PP2PD_binomTest <- binom.test(sum(Data1Gene_ExonicNonSyn_PP2PD[,32]), sum(c(Data1Gene_ExonicNonSyn_PP2PD[,32], Data2Gene_ExonicNonSyn_PP2PD[,32])))$p.value
			}
		}
		else {
			Data1Gene_ExonicNonSyn_PP2PD_RealScore <- "NA"
			Data1Gene_ExonicNonSyn_PP2PD_binomTest <- "NA"
		}

		if (nrow(Data1Gene_ExonicNonSyn_PP2D) > 0) {
			if (sum(c(Data1Gene_ExonicNonSyn_PP2D[,32], Data2Gene_ExonicNonSyn_PP2D[,32])) == 0) {
				Data1Gene_ExonicNonSyn_PP2D_RealScore <- "NA"
				Data1Gene_ExonicNonSyn_PP2D_binomTest <- "NA"
			}
			else {
				Data1Gene_ExonicNonSyn_PP2D_RealScore <- sum(Data1Gene_ExonicNonSyn_PP2D[,32]) / sum(c(Data1Gene_ExonicNonSyn_PP2D[,32], Data2Gene_ExonicNonSyn_PP2D[,32]))
				Data1Gene_ExonicNonSyn_PP2D_binomTest <- binom.test(sum(Data1Gene_ExonicNonSyn_PP2D[,32]), sum(c(Data1Gene_ExonicNonSyn_PP2D[,32], Data2Gene_ExonicNonSyn_PP2D[,32])))$p.value
			}
		}
		else {
			Data1Gene_ExonicNonSyn_PP2D_RealScore <- "NA"
			Data1Gene_ExonicNonSyn_PP2D_binomTest <- "NA"
		}

		write(c(Data1Gene_Exonic_RealScore, Data1Gene_ExonicNonSyn_RealScore, Data1Gene_ExonicNonSyn_PP2PD_RealScore, Data1Gene_ExonicNonSyn_PP2D_RealScore), stderr())

		if (is.null(Data1Gene_Exonic_RealScore) || is.null(Data1Gene_ExonicNonSyn_RealScore) || is.null(Data1Gene_ExonicNonSyn_PP2PD_RealScore) || is.null(Data1Gene_ExonicNonSyn_PP2D_RealScore)) {
			write(paste("Error1a -- One of the real scores is still null (", Data1Gene_Exonic_RealScore, Data1Gene_ExonicNonSyn_RealScore, Data1Gene_ExonicNonSyn_RealScore, Data1Gene_ExonicNonSyn_PP2D_RealScore, ")", sep=" "),  stderr())
			stop("Error1a")
		}

		
		Data1Gene_Exonic_pValCount <- 0
		Data1Gene_ExonicNonSyn_pValCount <- 0
		Data1Gene_ExonicNonSyn_PP2PD_pValCount <- 0
		Data1Gene_ExonicNonSyn_PP2D_pValCount <- 0

		for (i in 33:ncol(Data1)) {
	
			if (Data1Gene_Exonic_RealScore == "NA") {
				Data1Gene_Exonic_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
			}
			else {
				if (sum(c(Data1Gene_Exonic[,i], Data2Gene_Exonic[,i])) == 0) {
#					Data1Gene_Exonic_pValCount <- Data1Gene_Exonic_pValCount + 1
				}
				else {
					if (Data1Gene_Exonic_RealScore == .5) {
						Data1Gene_Exonic_pValCount <- Data1Gene_Exonic_pValCount + 1
					}
					else {
						if (Data1Gene_Exonic_RealScore < .5) {
							if ((sum(Data1Gene_Exonic[,i]) / sum(c(Data1Gene_Exonic[,i], Data2Gene_Exonic[,i]))) < .5) {
								if (binom.test(sum(Data1Gene_Exonic[,i]), sum(c(Data1Gene_Exonic[,i], Data2Gene_Exonic[,i])))$p.value < Data1Gene_Exonic_binomTest) {
									Data1Gene_Exonic_pValCount <- Data1Gene_Exonic_pValCount + 1	
								}
							}
						}
						else if (Data1Gene_Exonic_RealScore > .5) {
							if ((sum(Data1Gene_Exonic[,i]) / sum(c(Data1Gene_Exonic[,i], Data2Gene_Exonic[,i]))) > .5) {
								if (binom.test(sum(Data1Gene_Exonic[,i]), sum(c(Data1Gene_Exonic[,i], Data2Gene_Exonic[,i])))$p.value < Data1Gene_Exonic_binomTest) {
									Data1Gene_Exonic_pValCount <- Data1Gene_Exonic_pValCount + 1
								}
							}
						}
						else {
							warning(paste("Error2a -- Data1Gene_Exonic_RealScore is neither greater than or less than .5 (Case", FuncCall, ")", sep=" "))
						}
					}
				}
			}

			if (Data1Gene_ExonicNonSyn_RealScore == "NA") {
				Data1Gene_ExonicNonSyn_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
			}
			else {
				if (sum(c(Data1Gene_ExonicNonSyn[,i], Data2Gene_ExonicNonSyn[,i])) == 0) {
#					Data1Gene_ExonicNonSyn_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
				}
				else {
					if (Data1Gene_ExonicNonSyn_RealScore == .5) {
						Data1Gene_ExonicNonSyn_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
					}
					else {
						if (Data1Gene_ExonicNonSyn_RealScore < .5) {
							if ((sum(Data1Gene_ExonicNonSyn[,i]) / sum(c(Data1Gene_ExonicNonSyn[,i], Data2Gene_ExonicNonSyn[,i]))) < .5) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn[,i]), sum(c(Data1Gene_ExonicNonSyn[,i], Data2Gene_ExonicNonSyn[,i])))$p.value < Data1Gene_ExonicNonSyn_binomTest) {
									Data1Gene_ExonicNonSyn_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
								}
							}
						}
						else if (Data1Gene_ExonicNonSyn_RealScore > .5) {
							if ((sum(Data1Gene_ExonicNonSyn[,i]) / sum(c(Data1Gene_ExonicNonSyn[,i], Data2Gene_ExonicNonSyn[,i]))) > .5) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn[,i]), sum(c(Data1Gene_ExonicNonSyn[,i], Data2Gene_ExonicNonSyn[,i])))$p.value < Data1Gene_ExonicNonSyn_binomTest) {
									Data1Gene_ExonicNonSyn_pValCount <- Data1Gene_ExonicNonSyn_pValCount + 1
								}
							}
						}
						else {
							warning(paste("Error2b -- Data1Gene_ExonicNonSyn_RealScore is neither greater than or less than .5 (Case", FuncCall, ")", sep=" "))
						}
					}
				}
			}

			if (Data1Gene_ExonicNonSyn_PP2PD_RealScore == "NA") {
				Data1Gene_ExonicNonSyn_PP2PD_pValCount <- Data1Gene_ExonicNonSyn_PP2PD_pValCount + 1
			}
			else {
				if (sum(c(Data1Gene_ExonicNonSyn_PP2PD[,i], Data2Gene_ExonicNonSyn_PP2PD[,i])) == 0) {
#					Data1Gene_ExonicNonSyn_PP2PD_pValCount <- Data1Gene_ExonicNonSyn_PP2PD_pValCount + 1
				}
				else {
					if (Data1Gene_ExonicNonSyn_PP2PD_RealScore == .5) {
						Data1Gene_ExonicNonSyn_PP2PD_pValCount <- Data1Gene_ExonicNonSyn_PP2PD_pValCount + 1
					}
					else {
						if (Data1Gene_ExonicNonSyn_PP2PD_RealScore < .5) {
							if ((sum(Data1Gene_ExonicNonSyn_PP2PD[,i]) / sum(c(Data1Gene_ExonicNonSyn_PP2PD[,i], Data2Gene_ExonicNonSyn_PP2PD[,i]))) < .5) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn_PP2PD[,i]), sum(c(Data1Gene_ExonicNonSyn_PP2PD[,i], Data2Gene_ExonicNonSyn_PP2PD[,i])))$p.value < Data1Gene_ExonicNonSyn_PP2PD_binomTest) {
									Data1Gene_ExonicNonSyn_PP2PD_pValCount <- Data1Gene_ExonicNonSyn_PP2PD_pValCount + 1
								}
							}
						}
						else if (Data1Gene_ExonicNonSyn_PP2PD_RealScore > .5) {
							if ((sum(Data1Gene_ExonicNonSyn_PP2PD[,i]) / sum(c(Data1Gene_ExonicNonSyn_PP2PD[,i], Data2Gene_ExonicNonSyn_PP2PD[,i]))) > .5) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn_PP2PD[,i]), sum(c(Data1Gene_ExonicNonSyn_PP2PD[,i], Data2Gene_ExonicNonSyn_PP2PD[,i])))$p.value < Data1Gene_ExonicNonSyn_PP2PD_binomTest) {
									Data1Gene_ExonicNonSyn_PP2PD_pValCount <- Data1Gene_ExonicNonSyn_PP2PD_pValCount + 1
								}
							}
						}
						else {
							warning(paste("Error2c -- Data1Gene_ExonicNonSyn_PP2PD_RealScore is neither greater than or less than .5 (Case", FuncCall, ")", sep=" "))
						}
					}
				}
			}

			if (Data1Gene_ExonicNonSyn_PP2D_RealScore == "NA") {
				Data1Gene_ExonicNonSyn_PP2D_pValCount <- Data1Gene_ExonicNonSyn_PP2D_pValCount + 1
			}
			else {
				if (sum(c(Data1Gene_ExonicNonSyn_PP2D[,i], Data2Gene_ExonicNonSyn_PP2D[,i])) == 0) {
#					Data1Gene_ExonicNonSyn_PP2D_pValCount <- Data1Gene_ExonicNonSyn_PP2D_pValCount + 1
				}
				else {
					if (Data1Gene_ExonicNonSyn_PP2D_RealScore == .5) {
						Data1Gene_ExonicNonSyn_PP2D_pValCount <- Data1Gene_ExonicNonSyn_PP2D_pValCount + 1
					}
					else {
						if (Data1Gene_ExonicNonSyn_PP2D_RealScore < .5) {
							if ((sum(Data1Gene_ExonicNonSyn_PP2D[,i]) / sum(c(Data1Gene_ExonicNonSyn_PP2D[,i], Data2Gene_ExonicNonSyn_PP2D[,i]))) < Data1Gene_ExonicNonSyn_PP2D_RealScore) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn_PP2D[,i]), sum(c(Data1Gene_ExonicNonSyn_PP2D[,i], Data2Gene_ExonicNonSyn_PP2D[,i])))$p.value < Data1Gene_ExonicNonSyn_PP2D_binomTest) {
									Data1Gene_ExonicNonSyn_PP2D_pValCount <- Data1Gene_ExonicNonSyn_PP2D_pValCount + 1
								}
							}
						}
						else if (Data1Gene_ExonicNonSyn_PP2D_RealScore > .5) {
							if ((sum(Data1Gene_ExonicNonSyn_PP2D[,i]) / sum(c(Data1Gene_ExonicNonSyn_PP2D[,i], Data2Gene_ExonicNonSyn_PP2D[,i]))) > Data1Gene_ExonicNonSyn_PP2D_RealScore) {
								if (binom.test(sum(Data1Gene_ExonicNonSyn_PP2D[,i]), sum(c(Data1Gene_ExonicNonSyn_PP2D[,i], Data2Gene_ExonicNonSyn_PP2D[,i])))$p.value < Data1Gene_ExonicNonSyn_PP2D_binomTest) {
									Data1Gene_ExonicNonSyn_PP2D_pValCount <- Data1Gene_ExonicNonSyn_PP2D_pValCount + 1
								}
							}
						}
						else {
							warning(paste("Error2d -- Data1Gene_ExonicNonSyn_PP2D_RealScore is neither greater than or less than .5 (Case", FuncCall, ")", sep=" "))
						}
					}
				}
			}
		}

		FnlRslts_temp <- rbind(FnlRslts_temp, c(Gene, Pheno1, sum(Data1Gene_Exonic[,32]), sum(Data2Gene_Exonic[,32]), Data1Gene_Exonic_binomTest, Data1Gene_Exonic_pValCount, sum(Data1Gene_ExonicNonSyn[,32]), sum(Data2Gene_ExonicNonSyn[,32]), Data1Gene_ExonicNonSyn_binomTest, Data1Gene_ExonicNonSyn_pValCount, sum(Data1Gene_ExonicNonSyn_PP2PD[,32]), sum(Data2Gene_ExonicNonSyn_PP2PD[,32]), Data1Gene_ExonicNonSyn_PP2PD_binomTest, Data1Gene_ExonicNonSyn_PP2PD_pValCount, sum(Data1Gene_ExonicNonSyn_PP2D[,32]), sum(Data2Gene_ExonicNonSyn_PP2D[,32]), Data1Gene_ExonicNonSyn_PP2D_binomTest, Data1Gene_ExonicNonSyn_PP2D_pValCount))

	}

	return (FnlRslts_temp)

}

FnlRslts <- rbind(FnlRslts, AlleleCounts(cmd_args[5], cmd_args[6], "HIVAcquisition", 1))
FnlRslts <- rbind(FnlRslts, AlleleCounts(cmd_args[7], cmd_args[8], "AIDSProgression", 2))


write.table(FnlRslts, cmd_args[9], quote=FALSE, row.names=FALSE, col.names=FALSE)

#		write(Gene, stderr())

#		write.table(Data1Gene[1:5,], stderr())
#		write(c(dim(Data1Gene), dim(Data1Gene_Exonic), dim(Data1Gene_ExonicNonSyn), dim(Data1Gene_ExonicNonSyn_PP2PD), dim(Data1Gene_ExonicNonSyn_PP2D)), stderr())
#		write.table(Data1Gene_Exonic[1:5,], stderr())
#		write.table(Data1Gene_ExonicNonSyn[1:5,], stderr())
#		write.table(Data1Gene_ExonicNonSyn_PP2PD[1:5,], stderr())
#		write.table(Data1Gene_ExonicNonSyn_PP2D[1:5,], stderr())

#		write(paste(Data1Gene_ExonicNonSyn_PP2PD[,32], Data2Gene_ExonicNonSyn_PP2PD[,32], sum(Data1Gene_ExonicNonSyn_PP2PD[,32]), sum(Data2Gene_ExonicNonSyn_PP2PD[,32]), sum(c(Data1Gene_ExonicNonSyn_PP2PD[,32], Data2Gene_ExonicNonSyn_PP2PD[,32])), sep=" "), stderr())
