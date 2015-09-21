#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser
from random import randint

file1 = None

#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--r2", dest="r2", help="r2 value >= which to clump SNPs by", required=True, metavar="r2")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

# CHR_A         BP_A        SNP_A  CHR_B         BP_B        SNP_B           R2
#      1        54490      1:54490      1       662857     1:662857  3.20342e-06


chrList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
#chrList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,"X"]

for chr in chrList:

	sys.stderr.write("Processing chr: " + str(chr) + "...\n")
	
	hash1 = {}
	resultHash1 = {}
	
	if args.file1 == "-":
		file1 = sys.stdin
	elif re.search('gz$', args.file1):
		file1 = gzip.open(args.file1, 'rb')	
	else:
		file1 = open(args.file1, 'r')

	for line1 in file1:
		line1 = line1.rstrip().split()	

#		sys.stderr.write(",".join(line1) + "\n")

		if ((line1[0] == str(chr)) and (line1[3] == str(chr)) ):
#			sys.stderr.write("yay!\n")
			if line1[2] in hash1:
				hash1[line1[2]].append(line1)
			else:
				hash1[line1[2]] = [line1]

	file1.close()

	snpEntries = hash1.keys()

	while len(snpEntries) != 0:
		ranSNP = snpEntries[randint(0,len(snpEntries)-1)]
		
		if ranSNP in hash1:
			for snpEntry in hash1[ranSNP]:
				if float(snpEntry[6]) >= float(args.r2):
					if snpEntry[2] in resultHash1:
						resultHash1[snpEntry[2]].append([snpEntry[5],snpEntry[6]])
					else:
						resultHash1[snpEntry[2]] = [[snpEntry[5],snpEntry[6]]]
	
#					del snpEntries[snpEntry[5]]
#					filter(lambda a: a != snpEntry[5], snpEntries)
					snpEntries = [x for x in snpEntries if x != snpEntry[5]]
		else:
			sys.stderr.write("Error 1a -- ranSNP not found in hash1 (ranSNP: " + ranSNP + ")\n")

#		del snpEntries[ranSNP]
#		filter(lambda a: a != ranSNP, snpEntries)
		snpEntries = [x for x in snpEntries if x != ranSNP]
#		sys.stderr.write(str(len(snpEntries)) + "\n")

	for result1 in resultHash1:
		print result1 + "\t" + ",".join(map(str, resultHash1[result1]))


def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

