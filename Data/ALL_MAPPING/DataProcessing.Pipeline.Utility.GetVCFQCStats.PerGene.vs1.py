#!/usr/bin/python

import sys
import re
import gzip
import numpy
from argparse import ArgumentParser

file1 = None
hash1 = {}

#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz
#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.wAnnovarForQC.RanGenePerVariant.vcf.gz

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

def TiTv(ChrBPN, A1, A2):	#0 is for transitions, 1 is for transversions
	returnVal = None

	if (A1 == "A"):
		if (A2 == "G"):
			returnVal = 0
		elif (A2 == "C"):
			returnVal = 1
		elif (A2 == "T"):
			returnVal = 1
		else:
			sys.stderr.write("Error3b -- variant " + ChrBPN + " does not have proper other allele, skipping (" + A1 + "," + A2 + ")\n")
	elif (A1 == "G"):
		if (A2 == "A"):
			returnVal = 0
		elif (A2 == "C"):
			returnVal = 1
		elif (A2 == "T"):
			returnVal = 1
		else:
			sys.stderr.write("Error3b -- variant " + ChrBPN + " does not have proper other allele, skipping (" + A1 + "," + A2 + ")\n")
	elif (A1 == "C"):
		if (A2 == "A"):
			returnVal = 1
		elif (A2 == "G"):
			returnVal = 1
		elif (A2 == "T"):
			returnVal = 0
		else:
			sys.stderr.write("Error3b -- variant " + ChrBPN + " does not have proper other allele, skipping (" + A1 + "," + A2 + ")\n")
	elif (A1 == "T"):
		if (A2 == "A"):
			returnVal = 1
		elif (A2 == "G"):
			returnVal = 1
		elif (A2 == "C"):
			returnVal = 0
		else:
			sys.stderr.write("Error3b -- variant " + ChrBPN + " does not have proper other allele, skipping (" + A1 + "," + A2 + ")\n")
	else:		
		sys.stderr.write("Error3a -- variant " + ChrBPN + " does not have proper reference allele, skipping (" + A1 + "," + A2 + ")\n")

	return returnVal

#Main script

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')


for line1 in file1:
	line1 = line1.rstrip().split()	

	if re.search('^#', line1[0]):
		continue

	SNPqualities = line1[7].split(";")
	
	annovarQualities = line1[8].split(",")
	
	if annovarQualities[1] not in hash1:
		hash1[annovarQualities[1]] = {}
		hash1[annovarQualities[1]]["NumVar"] = 0
		hash1[annovarQualities[1]]["Exonic"] = 0
		hash1[annovarQualities[1]]["Intronic"] = 0
		hash1[annovarQualities[1]]["Intergenic"] = 0
		hash1[annovarQualities[1]]["UTR5"] = 0
		hash1[annovarQualities[1]]["UTR3"] = 0
		hash1[annovarQualities[1]]["Nonsynonymous"] = 0
		hash1[annovarQualities[1]]["Synonymous"] = 0
		hash1[annovarQualities[1]]["Stopgain"] = 0
		hash1[annovarQualities[1]]["Stoploss"] = 0
		hash1[annovarQualities[1]]["Depth"] = []
		hash1[annovarQualities[1]]["Transitions"] = 0
		hash1[annovarQualities[1]]["Transversions"] = 0
		hash1[annovarQualities[1]]["Quality"] = []
		hash1[annovarQualities[1]]["HPolymerRun"] = []
		hash1[annovarQualities[1]]["HaploScore"] = []
		hash1[annovarQualities[1]]["Singletons"] = 0
		hash1[annovarQualities[1]]["Doubletons"] = 0
		hash1[annovarQualities[1]]["Rare"] = 0
		hash1[annovarQualities[1]]["Common"] = 0
		hash1[annovarQualities[1]]["PP2_D"] = 0
		hash1[annovarQualities[1]]["PP2_P"] = 0
		hash1[annovarQualities[1]]["PP2_B"] = 0
		hash1[annovarQualities[1]]["PP2_Neg9"] = 0
		hash1[annovarQualities[1]]["Sift_D"] = 0
		hash1[annovarQualities[1]]["Sift_T"] = 0
		hash1[annovarQualities[1]]["Sift_Neg9"] = 0
		hash1[annovarQualities[1]]["LRT_D"] = 0
		hash1[annovarQualities[1]]["LRT_N"] = 0
		hash1[annovarQualities[1]]["LRT_U"] = 0
		hash1[annovarQualities[1]]["LRT_Neg9"] = 0

	ChrBP1 = line1[0] + "_" + line1[1]

	AA = None
	AAFlag1 = 0
	AC = None
	AF = None
	AN = None
	DP = None
	HRun = None
	HaplotypeScore = None

	for quality in SNPqualities:
		qualSubset = quality.split("=")

		if qualSubset[0] == "AA":
			AA = qualSubset[1]
			if line1[3] != AA.upper() and line1[4] != AA.upper():
				sys.stderr.write("Error2a -- variant " + "_".join(map(str, line1[0:2])) + " does not have either alleles as the AA (" + ",".join([AA, line1[3], line1[4]]) + "), skipping\n")
				AAFlag1 = 1
				continue
		if qualSubset[0] == "AC":
			AC = qualSubset[1]	
		if qualSubset[0] == "AF":
			AF = float(qualSubset[1])
		if qualSubset[0] == "AN":
			AN = qualSubset[1]
		if qualSubset[0] == "DP":
			DP = qualSubset[1]
#		if qualSubset[0] == "HRun":
#			HRun = qualSubset[1]
		if qualSubset[0] == "HaplotypeScore":
			HaplotypeScore = float(qualSubset[1])

	if AAFlag1 == 1:
		continue
	if (AA is None) or (not re.search("A|G|T|C|a|g|t|c", AA)):
		sys.stderr.write("Error1a -- variant " + "_".join(map(str, line1[0:2])) + " does not have proper AA field (" + str(AA) + "), skipping\n")
		continue
	if AC is None:
		sys.stderr.write("Error1b -- variant " + "_".join(map(str, line1[0:2])) + " does not have AC field, skipping\n")
		continue
	if AF is None:
		sys.stderr.write("Error1c -- variant " + "_".join(map(str, line1[0:2])) + " does not have AF field, skipping\n")
		continue
	if AN is None:
		sys.stderr.write("Error1d -- variant " + "_".join(map(str, line1[0:2])) + " does not have AN field, skipping\n")
		continue
	if DP is None:
		sys.stderr.write("Error1e -- variant " + "_".join(map(str, line1[0:2])) + " does not have DP field, skipping\n")
		continue
#	if HRun is None:
#		sys.stderr.write("Error1f -- variant " + "_".join(map(str, line1[0:2])) + " does not have HRun field, skipping\n")
#		continue
	if HaplotypeScore is None:
		sys.stderr.write("Error1g -- variant " + "_".join(map(str, line1[0:2])) + " does not have HaplotypeScore field, skipping\n")
		continue

	TiTvFlag = TiTv(ChrBP1, line1[3], line1[4])

	if TiTvFlag is None:
		sys.stderr.write("Error1c -- variant " + "_".join(map(str, line1[0:2])) + " does not have proper TiTv designation, skipping\n")
		continue

	if TiTvFlag == 0:
		hash1[annovarQualities[1]]["Transitions"] += 1
	elif TiTvFlag == 1:
		hash1[annovarQualities[1]]["Transversions"] += 1
	else:
		sys.exit("Error1d -- variant " + "_".join(map(str, line1[0:2])) + " does not have 0 or 1 for TiTvFlag (" + str(TiTvFlag) + "). Exiting...\n")
	
	hash1[annovarQualities[1]]["NumVar"] += 1
	
#	sys.stderr.write(DP + " " + AN + " \n")

	hash1[annovarQualities[1]]["Depth"].extend([float(DP)/(float(AN)/2.0)])
	hash1[annovarQualities[1]]["Quality"].extend([float(line1[5])])
#	HPolymerRun.extend([int(HRun)])
	hash1[annovarQualities[1]]["HaploScore"].extend([HaplotypeScore])

	if (AC == "1"):
		hash1[annovarQualities[1]]["Singletons"] += 1
	elif (AC == "2"):
		hash1[annovarQualities[1]]["Doubletons"] += 1
	else:
		PH = 1
			
	if (AF >= .05):
		hash1[annovarQualities[1]]["Common"] += 1
	elif (AF < .05):
		hash1[annovarQualities[1]]["Rare"] += 1
	else:
		sys.exit("Error2a -- AF is neither >= .05 or <.05 (" + str(AF) + "). Exiting...\n")
	
	if annovarQualities[0] == "exonic":
		hash1[annovarQualities[1]]["Exonic"] += 1
	elif annovarQualities[0] == "intronic":
		hash1[annovarQualities[1]]["Intronic"] +=1 
	elif annovarQualities[0] == "intergenic":
		hash1[annovarQualities[1]]["Intergenic"] +=1 
	elif annovarQualities[0] == "UTR5":
		hash1[annovarQualities[1]]["UTR5"] +=1 
	elif annovarQualities[0] == "UTR3":
		hash1[annovarQualities[1]]["UTR3"] +=1 
	else:
		PH = 1
	
	if annovarQualities[2] == "nonsynonymous_SNV":
		hash1[annovarQualities[1]]["Nonsynonymous"] += 1
	elif annovarQualities[2] == "synonymous_SNV":
		hash1[annovarQualities[1]]["Synonymous"] += 1
	elif annovarQualities[2] == "stopgain_SNV":
		hash1[annovarQualities[1]]["Stopgain"] += 1
	elif annovarQualities[2] == "stoploss_SNV":
		hash1[annovarQualities[1]]["Stoploss"] += 1
	else:
		PH = 1

	if annovarQualities[15] == "D":
		hash1[annovarQualities[1]]["PP2_D"] += 1
	elif annovarQualities[15] == "P":
		hash1[annovarQualities[1]]["PP2_P"] += 1
	elif annovarQualities[15] == "B":
		hash1[annovarQualities[1]]["PP2_B"] += 1
	elif annovarQualities[15] == "-9":
		hash1[annovarQualities[1]]["PP2_Neg9"] += 1
	else:
		PH = 1

	if annovarQualities[13] == "D":
		hash1[annovarQualities[1]]["Sift_D"] += 1
	elif annovarQualities[13] == "T":
		hash1[annovarQualities[1]]["Sift_T"] += 1
	elif annovarQualities[13] == "-9":
		hash1[annovarQualities[1]]["Sift_Neg9"] += 1
	else:
		PH = 1

	if annovarQualities[17] == "D":
		hash1[annovarQualities[1]]["LRT_D"] += 1
	elif annovarQualities[17] == "N":
		hash1[annovarQualities[1]]["LRT_N"] += 1
	elif annovarQualities[17] == "U":
		hash1[annovarQualities[1]]["LRT_U"] += 1
	elif annovarQualities[17] == "-9":
		hash1[annovarQualities[1]]["LRT_Neg9"] += 1
	else:
		PH = 1

file1.close()

for geneID in hash1:

	sys.stderr.write(str(geneID) + "," + str(hash1[geneID]["NumVar"]) + "\n")

	if hash1[geneID]["NumVar"] == 0:
		sys.stderr.write("Error 3a -- geneID " + str(geneID) + " has 0 variants (" + str(hash1[geneID]["NumVar"]) + "). Skipping...\n")
		continue

	meanDP = numpy.mean(hash1[geneID]["Depth"])
	stdDP = numpy.std(hash1[geneID]["Depth"])
	meanQual = numpy.mean(hash1[geneID]["Quality"])
	stdQual = numpy.std(hash1[geneID]["Quality"])
	#meanHRun = numpy.mean(hash1[geneID]["HPolymerRun"])
	#stdHRun = numpy.std(hash1[geneID]["HPolymerRun"])
	#minHRun = numpy.amin(hash1[geneID]["HPolymerRun"])
	#maxHRun = numpy.amax(hash1[geneID]["HPolymerRun"])
	Q1Haplo = numpy.percentile(hash1[geneID]["HaploScore"], 0)
	Q2Haplo = numpy.percentile(hash1[geneID]["HaploScore"], 25)
	Q3Haplo = numpy.percentile(hash1[geneID]["HaploScore"], 50)
	Q4Haplo = numpy.percentile(hash1[geneID]["HaploScore"], 75)
	Q5Haplo = numpy.percentile(hash1[geneID]["HaploScore"], 100)
	meanHaplo = numpy.mean(hash1[geneID]["HaploScore"])
	stdHaplo = numpy.std(hash1[geneID]["HaploScore"])

	TiTvRatio = "NA"

	if int(hash1[geneID]["Transversions"]) != 0: 
		TiTvRatio = float(hash1[geneID]["Transitions"]) / float(hash1[geneID]["Transversions"])

#Header
#geneID,NumVar,Exonic,ExonicProp,Intronic,IntronicProp,Intergenic,UTR5,UTR3,Nonsynonymous,NonsynonymousPropEx,Synonymous,SynonymousPropEx,Stopgain,StopgainPropEx,Stoploss,StoplossPropEx,MeanDP,stdDP,meanQual,stdQual,TiTvRatio,Transitions,Transversions,meanHaplo,stdHaplo,Singletons,SingletonsProp,Doubletons,DoubletonsProp,Common,CommonProp,Rare,RareProp,PP2_D,PP2_DProp,PP2_P,PP2_PProp,Sift_D,Sift_DProp,LRT_D,LRT_DProp

	print str(geneID) + "," + str(hash1[geneID]["NumVar"]) + "," + str(hash1[geneID]["Exonic"]) + "," + str(float(hash1[geneID]["Exonic"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Intronic"]) + "," + str(float(hash1[geneID]["Intronic"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Intergenic"]) + "," + str(hash1[geneID]["UTR5"]) + "," + str(hash1[geneID]["UTR3"]) + "," + str(hash1[geneID]["Nonsynonymous"]) + "," + str(float(hash1[geneID]["Nonsynonymous"])/float(hash1[geneID]["Exonic"])) + "," + str(hash1[geneID]["Synonymous"]) + "," + str(float(hash1[geneID]["Synonymous"])/float(hash1[geneID]["Exonic"])) + "," + str(hash1[geneID]["Stopgain"]) + "," + str(float(hash1[geneID]["Stopgain"])/float(hash1[geneID]["Exonic"])) + "," + str(hash1[geneID]["Stoploss"]) + "," + str(float(hash1[geneID]["Stoploss"])/float(hash1[geneID]["Exonic"])) + "," + str(meanDP) + "," + str(stdDP) + "," + str(meanQual) + "," + str(stdQual) + "," + str(TiTvRatio) + "," + str(hash1[geneID]["Transitions"]) + "," + str(hash1[geneID]["Transversions"]) + "," + str(meanHaplo) + "," + str(stdHaplo) + "," + str(hash1[geneID]["Singletons"]) + "," + str(float(hash1[geneID]["Singletons"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Doubletons"]) + "," + str(float(hash1[geneID]["Doubletons"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Common"]) + "," + str(float(hash1[geneID]["Common"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Rare"]) + "," + str(float(hash1[geneID]["Rare"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["PP2_D"]) + "," + str(float(hash1[geneID]["PP2_D"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["PP2_P"]) + "," + str(float(hash1[geneID]["PP2_P"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Sift_D"]) + "," + str(float(hash1[geneID]["Sift_D"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["LRT_D"]) + "," + str(float(hash1[geneID]["LRT_D"])/float(hash1[geneID]["NumVar"]))

#	print str(geneID) + "," + str(hash1[geneID]["NumVars"]) + "," + str(hash1[geneID]["Exonic"]) + "," + str(float(hash1[geneID]["Exonic"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Intronic"]) + "," + str(float(hash1[geneID]["Intronic"])/float(hash1[geneID]["NumVar"])) + "," + 
#	print str(hash1[geneID]["Intergenic"]) + "," + str(hash1[geneID]["UTR5"]) + "," + str(hash1[geneID]["UTR3"]) + "," + str(hash1[geneID]["Nonsynonymous"]) + "," + str(float(hash1[geneID]["Nonsynonymous"])/float(hash1[geneID]["Exonic"])) + "," +
#	print str(hash1[geneID]["Synonymous"]) + "," + str(float(hash1[geneID]["Synonymous"])/float(hash1[geneID]["Exonic"])) + "," + str(hash1[geneID]["Stopgain"]) + "," + str(float(hash1[geneID]["Stopgain"])/float(hash1[geneID]["Exonic"])) + "," +
#	print str(hash1[geneID]["Stoploss"]) + "," + str(float(hash1[geneID]["Stoploss"])/float(hash1[geneID]["Exonic"])) + "," + str(meanDP) + "," + str(stdDP) + "," + str(meanQual) + "," + str(stdQual) + "," + str(TiTvRatio) + "," + str(hash1[geneID]["Transitions"]) + "," + str(hash1[geneID]["Transversions"]) + ","
#	print str(hash1[geneID]["meanHaplo"]) + "," + str(hash1[geneID]["stdHaplo"]) + "," +
#	print str(hash1[geneID]["Singletons"]) + "," + str(float(hash1[geneID]["Singletons"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Doubletons"]) + "," + str(float(hash1[geneID]["Doubletons"])/float(hash1[geneID]["NumVar"])) + "," + 
#	print str(hash1[geneID]["Common"]) + "," + str(float(hash1[geneID]["Common"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["Rare"]) + "," + str(float(hash1[geneID]["Rare"])/float(hash1[geneID]["NumVar"])) + "," +
#	print str(hash1[geneID]["PP2_D"]) + "," + str(float(hash1[geneID]["PP2_D"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["PP2_P"]) + "," + str(float(hash1[geneID]["PP2_P"])/float(hash1[geneID]["NumVar"])) + "," +
#	print str(hash1[geneID]["Sift_D"]) + "," + str(float(hash1[geneID]["Sift_D"])/float(hash1[geneID]["NumVar"])) + "," + str(hash1[geneID]["LRT_D"]) + "," + str(float(hash1[geneID]["LRT_D"])/float(hash1[geneID]["NumVar"])) 

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

