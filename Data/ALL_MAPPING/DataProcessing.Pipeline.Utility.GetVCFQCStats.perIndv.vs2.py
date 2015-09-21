#!/usr/bin/python

import sys
import re
import gzip
import numpy
from argparse import ArgumentParser

file1 = None
hash1 = {}

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

#Main script

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

RowLength = None

for line1 in file1:
	line1 = line1.rstrip().split()	

	if re.search('^#CHROM', line1[0]):
		RowLength = len(line1)+1
		for i in range(9, len(line1)):
			if i+1 not in hash1:
				hash1[i+1] = { 
					'Name' : line1[i],
					'NumVariants' : 0,
					'Singletons' : 0,
					'Doubletons' : 0,
					'Rare' : 0,
					'Common' : 0,
					'Heterozygosities' : 0,
					'Coverage' : [],
					'DerivedAlleles' : 0,
					'Exonic' : 0,
					'Intronic' : 0,
					'Intergenic' : 0,
					'UTR5' : 0,
					'UTR3' : 0,
					'Nonsynonymous' : 0,
					'Synonymous' : 0,
					'Stoploss' : 0,
					'Stopgain' : 0,
					'PP2_D' : 0, 'PP2_P' : 0, 'PP2_B' : 0, 'PP2_Neg9' : 0,
					'Sift_D' : 0, 'Sift_T' : 0, 'Sift_Neg9' : 0,
					'LRT_D' : 0, 'LRT_N' : 0, 'LRT_U' : 0, 'LRT_Neg9' : 0,
				}
			else:
				sys.stderr.write("Error1a -- attempting to create more than one entry for hash1 (" + "\t".join(map(str, line1[0:10])) + ")\n")
	
	if re.search('^#', line1[0]):
		continue

	ChrBP1 = line1[0] + "_" + line1[1]

	AAFlag1 = 0
	AA = None
	AC = None
	AF = None
	AN = None
	DP = None

	SNPqualities = line1[7].split(";")

	for quality in SNPqualities:
		qualSubset = quality.split("=")

		if qualSubset[0] == "AA":
			AA = qualSubset[1]
			if line1[3] != AA.upper() and line1[4] != AA.upper():
				sys.stderr.write("Error2a -- variant " + "_".join(map(str, line1[0:2])) + " does not have either alleles as the AA (" + ",".join([AA, line1[3], line1[4]]) + "), skipping.\n")
#				continue
			else:
				AAFlag1 = 1
		if qualSubset[0] == "AC":
			AC = qualSubset[1]	
		if qualSubset[0] == "AF":
			AF = float(qualSubset[1])
		if qualSubset[0] == "AN":
			AN = qualSubset[1]
		if qualSubset[0] == "DP":
			DP = qualSubset[1]

###	if (AA is None) or (not re.search("A|G|T|C|a|g|t|c", AA)):
#	if AA is None:
#		sys.stderr.write("Error2b -- variant " + "_".join(map(str, line1[0:2])) + " does not have proper AA field, skipping\n")
#		continue
#	else:
#		if AAFlag1 == 0:
#			continue
	if AC is None:
		sys.stderr.write("Error2c -- variant " + "_".join(map(str, line1[0:2])) + " does not have AC field, skipping\n")
		continue
	if AF is None:
		sys.stderr.write("Error2d -- variant " + "_".join(map(str, line1[0:2])) + " does not have AF field, skipping\n")
		continue
	if AN is None:
		sys.stderr.write("Error2e -- variant " + "_".join(map(str, line1[0:2])) + " does not have AN field, skipping\n")
		continue
	if DP is None:
		sys.stderr.write("Error2f -- variant " + "_".join(map(str, line1[0:2])) + " does not have DP field, skipping\n")
		continue
	
	annovarQualities = line1[8].split(",")

	for j in range(10, len(line1)):
		indvQuals = line1[j].split(":")
		indvGenotypes = indvQuals[0].split("/")
		
		if indvGenotypes[0] == "." and indvGenotypes[1] == ".":
			continue
		
#		sys.stderr.write(",".join(map(str, indvQuals)) + "\n")
		indvDP = indvQuals[2]

		if indvDP == ".":
			sys.stderr.write("\t".join(map(str, line1[0:9])) + "\t" + str(line1[j]) + "\n")

		hash1[j]["Coverage"].extend([int(indvDP)])

		numCopies = 0
		if indvGenotypes[0] == "1":
			numCopies += 1
		if indvGenotypes[1] == "1":
			numCopies += 1
			
		if numCopies >= 1:

			hash1[j]["NumVariants"] += 1

			if AC == "1":
				hash1[j]["Singletons"] += 1
			if AC == "2":
				hash1[j]["Doubletons"] += 1

			if AF >= .05:
				hash1[j]["Common"] += 1
			elif AF < .05:
				hash1[j]["Rare"] += 1
			else:
				sys.exit("Error3a -- AF is neither >= .05 or <.05 (" + str(AF) + "). Exiting...\n")

			if numCopies == 1:
				hash1[j]["Heterozygosities"] += 1
	
			if AAFlag1 == 1:
				if line1[3] == AA.upper():
					hash1[j]["DerivedAlleles"] += numCopies
				elif line1[4] == AA.upper():
					hash1[j]["DerivedAlleles"] += 2 - numCopies
				else:
					sys.exit("Error3b -- variant " + "_".join(map(str, line1[0:2])) + " does not have AA allele at either position when it should have (" + ",".join([AA, line1[3], line1[4]]) + "). Exiting...\n")

			if annovarQualities[0] == "exonic":
				hash1[j]["Exonic"] += 1
			elif annovarQualities[0] == "intronic":
				hash1[j]["Intronic"] +=1 
			elif annovarQualities[0] == "intergenic":
				hash1[j]["Intergenic"] +=1 
			elif annovarQualities[0] == "UTR5":
				hash1[j]["UTR5"] +=1 
			elif annovarQualities[0] == "UTR3":
				hash1[j]["UTR3"] +=1 
			else:
				PH = 1
			
			if annovarQualities[2] == "nonsynonymous_SNV":
				hash1[j]["Nonsynonymous"] += 1
			elif annovarQualities[2] == "synonymous_SNV":
				hash1[j]["Synonymous"] += 1
			elif annovarQualities[2] == "stopgain_SNV":
				hash1[j]["Stopgain"] += 1
			elif annovarQualities[2] == "stoploss_SNV":
				hash1[j]["Stoploss"] += 1
			else:
				PH = 1

			if annovarQualities[15] == "D":
				hash1[j]["PP2_D"] += 1
			elif annovarQualities[15] == "P":
				hash1[j]["PP2_P"] += 1
			elif annovarQualities[15] == "B":
				hash1[j]["PP2_B"] += 1
			elif annovarQualities[15] == "-9":
				hash1[j]["PP2_Neg9"] += 1
			else:
				PH = 1

			if annovarQualities[13] == "D":
				hash1[j]["Sift_D"] += 1
			elif annovarQualities[13] == "T":
				hash1[j]["Sift_T"] += 1
			elif annovarQualities[13] == "-9":
				hash1[j]["Sift_Neg9"] += 1
			else:
				PH = 1

			if annovarQualities[17] == "D":
				hash1[j]["LRT_D"] += 1
			elif annovarQualities[17] == "N":
				hash1[j]["LRT_N"] += 1
			elif annovarQualities[17] == "U":
				hash1[j]["LRT_U"] += 1
			elif annovarQualities[17] == "-9":
				hash1[j]["LRT_Neg9"] += 1
			else:
				PH = 1

file1.close()

for k in range(10, RowLength):
	meanCoverage = numpy.mean(hash1[k]["Coverage"])
	stdCoverage = numpy.std(hash1[k]["Coverage"])

	print "Indv: " + str(hash1[k]["Name"]) + " NumVariants: " + str(hash1[k]["NumVariants"]) + " Singletons: " + str(hash1[k]["Singletons"]) + " Doubletons: " + str(hash1[k]["Doubletons"]) + " Common: " + str(hash1[k]["Common"]) + " Rare: " + str(hash1[k]["Rare"]) + " Heterozygosities: " + str(hash1[k]["Heterozygosities"]) + " meanCoverage: " + str(meanCoverage) + " CoverageStd: " + str(stdCoverage) + " NumDerivedAlleles: " + str(hash1[k]["DerivedAlleles"]) + \
	" Exonic: " + str(hash1[k]["Exonic"]) + " Intronic: " + str(hash1[k]["Intronic"]) + " Intergenic: " + str(hash1[k]["Intergenic"]) + " UTR5: " + str(hash1[k]["UTR5"]) + " UTR3: " + str(hash1[k]["UTR3"]) + " Nonsynonynmous: " + str(hash1[k]["Nonsynonymous"]) + " Synonymous: " + str(hash1[k]["Synonymous"]) + " Stoploss: " + str(hash1[k]["Stoploss"]) + " Stopgain: " + str(hash1[k]["Stopgain"]) + \
	" PP2_D: " + str(hash1[k]["PP2_D"]) + " PP2_P: " + str(hash1[k]["PP2_P"]) + " PP2_B: " + str(hash1[k]["PP2_B"]) + " PP2_-9: " + str(hash1[k]["PP2_Neg9"]) + " Sift_D: " + str(hash1[k]["Sift_D"]) + " Sift_T: " + str(hash1[k]["Sift_T"]) + " Sift_-9: " + str(hash1[k]["Sift_Neg9"]) + " LRT_D: " + str(hash1[k]["LRT_D"]) + " LRT_N: " + str(hash1[k]["LRT_N"]) + " LRT_U: " + str(hash1[k]["LRT_U"]) + " LRT_-9: " + str(hash1[k]["LRT_Neg9"])

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

