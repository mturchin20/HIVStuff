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

NumVar = 0
Exonic = 0
Intronic = 0
Intergenic = 0
UTR5 = 0
UTR3 = 0
Nonsynonymous = 0
Synonymous = 0
Stopgain = 0
Stoploss = 0
Depth = []
Transitions = 0
Transversions = 0
Quality = []
HPolymerRun = []
HaploScore = []
Singletons = 0
Doubletons = 0
Rare = 0
Common = 0
PP2_D = 0
PP2_P = 0
PP2_B = 0
PP2_Neg9 = 0
Sift_D = 0
Sift_T = 0
Sift_Neg9 = 0
LRT_D = 0
LRT_N = 0
LRT_U = 0
LRT_Neg9 = 0

for line1 in file1:
	line1 = line1.rstrip().split()	

	if re.search('^#', line1[0]):
		continue

	ChrBP1 = line1[0] + "_" + line1[1]

	AA = None
	AAFlag1 = 0
	AC = None
	AF = None
	AN = None
	DP = None
	HRun = None
	HaplotypeScore = None

	SNPqualities = line1[7].split(";")

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
		Transitions += 1
	elif TiTvFlag == 1:
		Transversions += 1
	else:
		sys.exit("Error1d -- variant " + "_".join(map(str, line1[0:2])) + " does not have 0 or 1 for TiTvFlag (" + str(TiTvFlag) + "). Exiting...\n")
	
	NumVar += 1
	
#	sys.stderr.write(DP + " " + AN + " \n")

	Depth.extend([float(DP)/(float(AN)/2.0)])
	Quality.extend([float(line1[5])])
#	HPolymerRun.extend([int(HRun)])
	HaploScore.extend([HaplotypeScore])

	if (AC == "1"):
		Singletons += 1
	elif (AC == "2"):
		Doubletons += 1
	else:
		PH = 1
			
	if (AF >= .05):
		Common += 1
	elif (AF < .05):
		Rare += 1
	else:
		sys.exit("Error2a -- AF is neither >= .05 or <.05 (" + str(AF) + "). Exiting...\n")

	annovarQualities = line1[8].split(",")
	
	if annovarQualities[0] == "exonic":
		Exonic += 1
	elif annovarQualities[0] == "intronic":
		Intronic +=1 
	elif annovarQualities[0] == "intergenic":
		Intergenic +=1 
	elif annovarQualities[0] == "UTR5":
		UTR5 +=1 
	elif annovarQualities[0] == "UTR3":
		UTR3 +=1 
	else:
		PH = 1
	
	if annovarQualities[2] == "nonsynonymous_SNV":
		Nonsynonymous += 1
	elif annovarQualities[2] == "synonymous_SNV":
		Synonymous += 1
	elif annovarQualities[2] == "stopgain_SNV":
		Stopgain += 1
	elif annovarQualities[2] == "stoploss_SNV":
		Stoploss += 1
	else:
		PH = 1

	if annovarQualities[15] == "D":
		PP2_D += 1
	elif annovarQualities[15] == "P":
		PP2_P += 1
	elif annovarQualities[15] == "B":
		PP2_B += 1
	elif annovarQualities[15] == "-9":
		PP2_Neg9 += 1
	else:
		PH = 1

	if annovarQualities[13] == "D":
		Sift_D += 1
	elif annovarQualities[13] == "T":
		Sift_T += 1
	elif annovarQualities[13] == "-9":
		Sift_Neg9 += 1
	else:
		PH = 1

	if annovarQualities[17] == "D":
		LRT_D += 1
	elif annovarQualities[17] == "N":
		LRT_N += 1
	elif annovarQualities[17] == "U":
		LRT_U += 1
	elif annovarQualities[17] == "-9":
		LRT_Neg9 += 1
	else:
		PH = 1

file1.close()

meanDP = numpy.mean(Depth)
stdDP = numpy.std(Depth)
meanQual = numpy.mean(Quality)
stdQual = numpy.std(Quality)
#meanHRun = numpy.mean(HPolymerRun)
#stdHRun = numpy.std(HPolymerRun)
#minHRun = numpy.amin(HPolymerRun)
#maxHRun = numpy.amax(HPolymerRun)
Q1Haplo = numpy.percentile(HaploScore, 0)
Q2Haplo = numpy.percentile(HaploScore, 25)
Q3Haplo = numpy.percentile(HaploScore, 50)
Q4Haplo = numpy.percentile(HaploScore, 75)
Q5Haplo = numpy.percentile(HaploScore, 100)
meanHaplo = numpy.mean(HaploScore)
stdHaplo = numpy.std(HaploScore)

TiTvRatio = float(Transitions) / float(Transversions)

print "NumVar: " + str(NumVar) + " Exonic: " + str(Exonic) + " Intronic: " + str(Intronic) + " Intergenic: " + str(Intergenic) + " UTR5: " + str(UTR5) + " UTR3: " + str(UTR3)
print "Synonymous: " + str(Synonymous) + " Nonsynonymous: " + str(Nonsynonymous) + " Stopgain: " + str(Stopgain) + " Stoploss: " + str(Stoploss)
print "PP2_D: " + str(PP2_D) + " PP2_P: " + str(PP2_P) + " PP2_B: " + str(PP2_B) + " PP2_-9: " + str(PP2_Neg9) + " Sift_D: " + str(Sift_D) + " Sift_T: " + str(Sift_T) + " Sift_-9: " + str(Sift_Neg9) + " LRT_D: " + str(LRT_D) + " LRT_N: " + str(LRT_N) + " LRT_U: " + str(LRT_U) + " LRT_-9: " + str(LRT_Neg9)
print "Common: " + str(Common) + " Rare: " + str(Rare) + " Singletons: " + str(Singletons) + " Doubletons: " + str(Doubletons)
print "MeanQuality: " + str(meanQual) + " QualityStd: " + str(stdQual) + " MeanDepth: " + str(meanDP) + " DepthStd: " + str(stdDP) + " TiTvRatio: " + str(TiTvRatio) + " Transitions: " + str(Transitions) + " Transversions: " + str(Transversions)
#print "MeanHRun: " + str(meanHRun) + " HRunStd: " + str(stdHRun) + " minHRun: " + str(minHRun) + " maxHRun: " + str(maxHRun) 
print "MeanHapScore: " + str(meanHaplo) + " HapScoreStd: " + str(stdHaplo) + " HapScore0Quart: " + str(Q1Haplo) + " HapScore25Quart: " + str(Q2Haplo) + " HapScore50Quart: " + str(Q3Haplo) + " HapScore75Quart: " + str(Q4Haplo) + " HapScore100Quart: " + str(Q5Haplo)

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

