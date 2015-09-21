#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
hash1 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.FreqInfo.AnnovarAnnotation.vs6.txt.gz 

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

for line1 in file1:
	line1 = line1.rstrip().split(",")

#	print(line1)

	ChrBP1 = line1[0] + "_" + line1[1].split("_")[0] 

#	print(ChrBP1)

#	if not line1[25]:
#		line1[25] = "."
#	if not line1[26]:
#		line1[26] = "."
#	if not line1[27]:
#		line1[27] = "."
#	if not line1[28]:
#		line1[28] = "."

	if ChrBP1 in hash1:
		hash1[ChrBP1].append([ChrBP1, line1[25], line1[26], "_".join(line1[27].split(" ")), line1[28]])

	else:
		hash1[ChrBP1] = [[ChrBP1, line1[25], line1[26], "_".join(line1[27].split(" ")), line1[28]]]

file1.close()

for entry1 in hash1:
	printLine1 = []
#	ChrBP2 = str(hash1[entry1][0][0].split("_")[0]) + "\t" + str(hash1[entry1][0][0].split("_")[1]) + "\t" + str(hash1[entry1][0][0].split("_")[1])
	ChrBP2 = hash1[entry1][0][0]
#	for info1 in entry1:
	for i in range (0, len(hash1[entry1])):
		for j in range (1, len(hash1[entry1][i])):
			if not hash1[entry1][i][j]:
				hash1[entry1][i][j] = "."
		
			if not printLine1:
				printLine1.insert(0,[ChrBP2])
			
			try:
				printLine1[j].extend([hash1[entry1][i][j]])
			except IndexError:
				printLine1.insert(j, [hash1[entry1][i][j]])
#			else:
#				printLine1[j].extend(hash1[entry1][i][j])
	
#		printLine1[i] = ",".join(map(str, entry1[i]))

	printLine2 = ""
	for printEntry1 in printLine1:
		printLine2 = printLine2 + ",".join(map(str, printEntry1)) + "\t"
	
	print printLine2


def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

